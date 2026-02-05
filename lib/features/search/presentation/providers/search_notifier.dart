// Search notifier for search functionality
// Manages search query, results, history, and suggestions
// Caches trending searches so switching to search tab shows content immediately

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/core/network/services/pexels_api_service.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';
import 'package:pinterest/features/search/presentation/providers/discover_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier({
    required PexelsApiService pexelsService,
    required LocalStorageService localStorage,
  })  : _pexelsService = pexelsService,
        _localStorage = localStorage,
        super(const SearchState()) {
    _initialize();
  }

  static const _trendingCacheDuration = Duration(minutes: 30);

  final PexelsApiService _pexelsService;
  final LocalStorageService _localStorage;
  Timer? _debounceTimer;

  /// In-memory cache of search results by query. Same query returns cache; refresh only on explicit pull-to-refresh.
  final Map<String, _CachedSearchResult> _searchResultCache = {};

  static const _recentSearchesKey = 'recent_searches';
  static const _maxRecentSearches = 10;
  static const _maxSearchResultCaches = 20;

  // Predefined trending searches
  static const List<Map<String, String>> _trendingData = [
    {'query': 'Aesthetic wallpapers', 'imageQuery': 'aesthetic wallpaper'},
    {'query': 'Outfit ideas', 'imageQuery': 'fashion outfit'},
    {'query': 'Room decor', 'imageQuery': 'room decoration'},
    {'query': 'Nail designs', 'imageQuery': 'nail art'},
    {'query': 'Hairstyles', 'imageQuery': 'hairstyle'},
    {'query': 'Tattoo ideas', 'imageQuery': 'tattoo design'},
    {'query': 'Recipes', 'imageQuery': 'food recipe'},
    {'query': 'Wedding', 'imageQuery': 'wedding decoration'},
  ];

  Future<void> _initialize() async {
    await _loadRecentSearches();

    // Show cached trending immediately if valid. No auto-refresh on tab switch.
    final restored = _restoreCachedTrending();
    if (restored) return;
    await _loadTrendingSearches();
  }

  bool _restoreCachedTrending() {
    try {
      final cacheJson = _localStorage.getJson(StorageKeys.trendingSearchCache);
      if (cacheJson == null) return false;

      final cachedAt = DateTime.tryParse(cacheJson['cachedAt'] as String? ?? '');
      if (cachedAt == null ||
          DateTime.now().difference(cachedAt) > _trendingCacheDuration) {
        return false;
      }

      final list = cacheJson['trendingSearches'] as List<dynamic>?;
      if (list == null || list.isEmpty) return false;

      final trendingSearches = list
          .map((e) => TrendingSearch.fromJson(e as Map<String, dynamic>))
          .toList();
      state = state.copyWith(trendingSearches: trendingSearches);
      return true;
    } catch (_) {
      return false;
    }
  }

  void _persistTrendingCache() {
    try {
      final cache = {
        'cachedAt': DateTime.now().toIso8601String(),
        'trendingSearches':
            state.trendingSearches.map((e) => e.toJson()).toList(),
      };
      _localStorage.setJson(StorageKeys.trendingSearchCache, cache);
    } catch (_) {}
  }

  Future<void> _loadRecentSearches() async {
    final stored = _localStorage.getStringList(_recentSearchesKey);
    if (stored != null && stored.isNotEmpty) {
      final recentSearches = stored.map((query) {
        return RecentSearch(
          query: query,
          timestamp: DateTime.now(),
        );
      }).toList();

      state = state.copyWith(recentSearches: recentSearches);
    }
  }

  Future<void> _loadTrendingSearches() async {
    final trendingSearches = <TrendingSearch>[];

    for (int i = 0; i < _trendingData.length; i++) {
      try {
        final data = _trendingData[i];
        final result = await _pexelsService.searchPhotos(
          query: data['imageQuery']!,
          perPage: 1,
        );

        if (result.pins.isNotEmpty) {
          trendingSearches.add(TrendingSearch(
            query: data['query']!,
            imageUrl: result.pins.first.imageUrl,
            rank: i + 1,
          ));
        }
      } catch (_) {
        // Add without image if fetch fails
        trendingSearches.add(TrendingSearch(
          query: _trendingData[i]['query']!,
          imageUrl: '',
          rank: i + 1,
        ));
      }
    }

    state = state.copyWith(trendingSearches: trendingSearches);
    _persistTrendingCache();
  }

  void enterSearchMode() {
    state = state.copyWith(isSearchMode: true);
  }

  void exitSearchMode() {
    _debounceTimer?.cancel();
    state = state.copyWith(
      isSearchMode: false,
      query: '',
      suggestions: [],
      results: [],
      currentPage: 1,
      hasMore: true,
    );
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query);

    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      state = state.copyWith(
        suggestions: [],
        results: [],
      );
      return;
    }

    // Debounce suggestions
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _generateSuggestions(query);
    });
  }

  void _generateSuggestions(String query) {
    // Generate suggestions based on query and trending
    final suggestions = <String>[];
    final lowerQuery = query.toLowerCase();

    // Add trending searches that match
    for (final trending in state.trendingSearches) {
      if (trending.query.toLowerCase().contains(lowerQuery)) {
        suggestions.add(trending.query);
      }
    }

    // Add common search patterns
    final patterns = [
      '$query ideas',
      '$query aesthetic',
      '$query inspiration',
      '$query design',
      'diy $query',
    ];

    for (final pattern in patterns) {
      if (!suggestions.contains(pattern) && suggestions.length < 8) {
        suggestions.add(pattern);
      }
    }

    state = state.copyWith(suggestions: suggestions.take(8).toList());
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final cacheKey = trimmed.toLowerCase();

    // Pinterest-style: show cached results for same query immediately; no refetch.
    final cached = _searchResultCache[cacheKey];
    if (cached != null) {
      final results = _deduplicateById(cached.results);
      state = state.copyWith(
        query: trimmed,
        results: results,
        currentPage: cached.currentPage,
        hasMore: cached.hasMore,
        isSearching: false,
        error: null,
      );
      await _saveRecentSearch(trimmed);
      return;
    }

    state = state.copyWith(
      query: trimmed,
      isSearching: true,
      error: null,
      currentPage: 1,
      hasMore: true,
    );

    try {
      final result = await _pexelsService.searchPhotos(
        query: trimmed,
        page: 1,
        perPage: 20,
      );

      final pins = _deduplicateById(result.pins);
      state = state.copyWith(
        isSearching: false,
        results: pins,
        hasMore: result.hasNextPage,
      );
      _searchResultCache[cacheKey] = _CachedSearchResult(
        results: pins,
        currentPage: 1,
        hasMore: result.hasNextPage,
      );
      _evictSearchCacheIfNeeded();

      await _saveRecentSearch(trimmed);
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        error: 'Failed to search. Please try again.',
      );
    }
  }

  /// Keeps first occurrence of each pin id so Hero tags stay unique in the grid.
  List<Pin> _deduplicateById(List<Pin> pins) {
    final seen = <String>{};
    return pins.where((p) => seen.add(p.id)).toList();
  }

  void _evictSearchCacheIfNeeded() {
    if (_searchResultCache.length <= _maxSearchResultCaches) return;
    final keys = _searchResultCache.keys.toList();
    for (var i = 0; i < keys.length - _maxSearchResultCaches; i++) {
      _searchResultCache.remove(keys[i]);
    }
  }

  /// Refreshes current search results (pull-to-refresh). Only refetches when user explicitly refreshes.
  Future<void> refreshSearchResults() async {
    if (!state.hasQuery) return;

    state = state.copyWith(isSearching: true, error: null);

    try {
      final result = await _pexelsService.searchPhotos(
        query: state.query,
        page: 1,
        perPage: 20,
      );

      final pins = _deduplicateById(result.pins);
      state = state.copyWith(
        isSearching: false,
        results: pins,
        currentPage: 1,
        hasMore: result.hasNextPage,
      );
      final cacheKey = state.query.trim().toLowerCase();
      _searchResultCache[cacheKey] = _CachedSearchResult(
        results: pins,
        currentPage: 1,
        hasMore: result.hasNextPage,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        error: 'Failed to refresh. Please try again.',
      );
    }
  }

  Future<void> loadMoreResults() async {
    if (state.isSearching || !state.hasMore || !state.hasQuery) return;

    state = state.copyWith(isSearching: true);

    try {
      final nextPage = state.currentPage + 1;
      final result = await _pexelsService.searchPhotos(
        query: state.query,
        page: nextPage,
        perPage: 20,
      );

      final newResults = _deduplicateById([...state.results, ...result.pins]);
      state = state.copyWith(
        isSearching: false,
        results: newResults,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
      final cacheKey = state.query.trim().toLowerCase();
      _searchResultCache[cacheKey] = _CachedSearchResult(
        results: newResults,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        error: 'Failed to load more results.',
      );
    }
  }

  Future<void> _saveRecentSearch(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    // Remove if exists and add to front
    final currentSearches = state.recentSearches
        .where((s) => s.query.toLowerCase() != trimmedQuery.toLowerCase())
        .toList();

    final newSearch = RecentSearch(
      query: trimmedQuery,
      timestamp: DateTime.now(),
    );

    final updatedSearches = [newSearch, ...currentSearches]
        .take(_maxRecentSearches)
        .toList();

    state = state.copyWith(recentSearches: updatedSearches);

    // Persist to storage
    await _localStorage.setStringList(
      _recentSearchesKey,
      updatedSearches.map((s) => s.query).toList(),
    );
  }

  Future<void> removeRecentSearch(String query) async {
    final updatedSearches = state.recentSearches
        .where((s) => s.query != query)
        .toList();

    state = state.copyWith(recentSearches: updatedSearches);

    await _localStorage.setStringList(
      _recentSearchesKey,
      updatedSearches.map((s) => s.query).toList(),
    );
  }

  Future<void> clearRecentSearches() async {
    state = state.copyWith(recentSearches: []);
    await _localStorage.remove(_recentSearchesKey);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

/// In-memory cache entry for one search query.
class _CachedSearchResult {
  _CachedSearchResult({
    required this.results,
    required this.currentPage,
    required this.hasMore,
  });

  final List<Pin> results;
  final int currentPage;
  final bool hasMore;
}

// Provider for search state
final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(
    pexelsService: getIt<PexelsApiService>(),
    localStorage: getIt<LocalStorageService>(),
  );
});

// Selector providers for granular rebuilds
final searchQueryProvider = Provider<String>((ref) {
  return ref.watch(searchProvider.select((s) => s.query));
});

final searchIsSearchModeProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider.select((s) => s.isSearchMode));
});

final searchIsSearchingProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider.select((s) => s.isSearching));
});

final searchResultsProvider = Provider<List<Pin>>((ref) {
  return ref.watch(searchProvider.select((s) => s.results));
});

final searchRecentSearchesProvider = Provider<List<RecentSearch>>((ref) {
  return ref.watch(searchProvider.select((s) => s.recentSearches));
});

final searchTrendingSearchesProvider = Provider<List<TrendingSearch>>((ref) {
  return ref.watch(searchProvider.select((s) => s.trendingSearches));
});

final searchSuggestionsProvider = Provider<List<String>>((ref) {
  return ref.watch(searchProvider.select((s) => s.suggestions));
});

final searchErrorProvider = Provider<String?>((ref) {
  return ref.watch(searchProvider.select((s) => s.error));
});

final searchHasMoreProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider.select((s) => s.hasMore));
});
