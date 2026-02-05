// Discover notifier for search/discover screen
// Fetches hero items, categories, and idea boards from Pexels API
// Uses local cache so switching to search tab shows content immediately

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/core/network/services/pexels_api_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';
import 'package:pinterest/features/search/presentation/providers/discover_state.dart';

class DiscoverNotifier extends StateNotifier<DiscoverState> {
  DiscoverNotifier({
    required PexelsApiService pexelsService,
    required LocalStorageService localStorage,
  })  : _pexelsService = pexelsService,
        _localStorage = localStorage,
        super(const DiscoverState()) {
    _initialize();
  }

  static const _cacheDuration = Duration(minutes: 30);

  final PexelsApiService _pexelsService;
  final LocalStorageService _localStorage;

  // Predefined hero data matching Pinterest style
  static const List<Map<String, String>> _heroData = [
    {
      'query': 'gourmet food plating',
      'subtitle': 'Foods on trend',
      'headline': 'Viral recipes to create',
    },
    {
      'query': 'dreamy art painting',
      'subtitle': 'A treat for your eyes',
      'headline': 'Calming dreamy art',
    },
    {
      'query': 'aesthetic room decor',
      'subtitle': 'Home inspo',
      'headline': 'Room makeover ideas',
    },
    {
      'query': 'fashion outfit style',
      'subtitle': 'Style picks',
      'headline': 'Outfits to recreate',
    },
    {
      'query': 'travel destination landscape',
      'subtitle': 'Wanderlust',
      'headline': 'Dream destinations',
    },
    {
      'query': 'nail art design',
      'subtitle': 'Beauty trends',
      'headline': 'Nail art inspiration',
    },
    {
      'query': 'diy crafts home',
      'subtitle': 'Get creative',
      'headline': 'DIY projects to try',
    },
  ];

  static const List<Map<String, String>> _categoryData = [
    {'name': 'Indian dress up', 'query': 'indian ethnic fashion saree'},
    {'name': 'Crochet ideas', 'query': 'crochet knitting handmade'},
    {'name': 'Pixel art', 'query': 'pixel art digital retro'},
    {'name': 'Home decor', 'query': 'home decor interior modern'},
    {'name': 'Food recipes', 'query': 'food recipe cooking'},
    {'name': 'Travel destinations', 'query': 'travel landscape nature'},
  ];

  static const List<Map<String, dynamic>> _ideaBoardData = [
    {
      'title': 'Funny Pins for girls with a great sense of humor',
      'creator': 'Aesthetics',
      'query': 'funny cat meme aesthetic',
      'isVerified': true,
      'pinCount': 30,
      'timeAgo': '8mo',
    },
    {
      'title': 'Level up your screen aesthetics',
      'creator': 'Aesthetics',
      'query': 'phone wallpaper aesthetic',
      'isVerified': true,
      'pinCount': 75,
      'timeAgo': '1mo',
    },
    {
      'title': 'Cozy bedroom makeover ideas',
      'creator': 'Home Design',
      'query': 'cozy bedroom interior',
      'isVerified': true,
      'pinCount': 120,
      'timeAgo': '2mo',
    },
    {
      'title': 'Minimalist lifestyle tips',
      'creator': 'Minimal Life',
      'query': 'minimalist lifestyle aesthetic',
      'isVerified': true,
      'pinCount': 45,
      'timeAgo': '3mo',
    },
  ];

  Future<void> _initialize() async {
    if (state.isInitialized) return;

    // Try cache first so switching to search tab shows content immediately.
    // No auto-refresh: data stays until user explicitly pulls to refresh.
    final restored = await _restoreCachedDiscover();
    if (restored) {
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      await Future.wait([
        _loadHeroItems(),
        _loadIdeaBoards(),
        _loadPopularCategories(),
      ]);

      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
      );
      _persistDiscoverCache();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load discover content',
      );
    }
  }

  /// Restores discover content from local cache. Returns true if valid cache was applied.
  Future<bool> _restoreCachedDiscover() async {
    try {
      final cacheJson = _localStorage.getJson(StorageKeys.discoverCache);
      if (cacheJson == null) return false;

      final cachedAt = DateTime.tryParse(cacheJson['cachedAt'] as String? ?? '');
      if (cachedAt == null ||
          DateTime.now().difference(cachedAt) > _cacheDuration) {
        return false;
      }

      final heroList = cacheJson['heroItems'] as List<dynamic>?;
      final ideaList = cacheJson['ideaBoards'] as List<dynamic>?;
      final categoryList = cacheJson['popularCategories'] as List<dynamic>?;

      final heroItems = heroList
              ?.map((e) => HeroItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <HeroItem>[];
      final ideaBoards = ideaList
              ?.map((e) => IdeaBoard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <IdeaBoard>[];
      final popularCategories = categoryList
              ?.map((e) =>
                  DiscoverCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <DiscoverCategory>[];

      if (heroItems.isEmpty && ideaBoards.isEmpty && popularCategories.isEmpty) {
        return false;
      }

      state = state.copyWith(
        heroItems: heroItems,
        ideaBoards: ideaBoards,
        popularCategories: popularCategories,
        categoryPins: {}, // Fetched on demand when user taps category
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  void _persistDiscoverCache() {
    try {
      final cache = {
        'cachedAt': DateTime.now().toIso8601String(),
        'heroItems': state.heroItems.map((e) => e.toJson()).toList(),
        'ideaBoards': state.ideaBoards.map((e) => e.toJson()).toList(),
        'popularCategories':
            state.popularCategories.map((e) => e.toJson()).toList(),
      };
      _localStorage.setJson(StorageKeys.discoverCache, cache);
    } catch (_) {}
  }

  Future<void> _loadHeroItems() async {
    final heroItems = <HeroItem>[];

    for (int i = 0; i < _heroData.length; i++) {
      try {
        final data = _heroData[i];
        final result = await _pexelsService.searchPhotos(
          query: data['query']!,
          perPage: 1,
          size: 'large',
        );

        if (result.pins.isNotEmpty) {
          final pin = result.pins.first;
          heroItems.add(HeroItem(
            id: 'hero_$i',
            imageUrl: pin.imageUrl,
            subtitle: data['subtitle']!,
            headline: data['headline']!,
          ));
        }
      } catch (_) {
        // Skip failed hero items
      }
    }

    state = state.copyWith(heroItems: heroItems);
  }

  Future<void> _loadIdeaBoards() async {
    final ideaBoards = <IdeaBoard>[];

    for (int i = 0; i < _ideaBoardData.length; i++) {
      try {
        final data = _ideaBoardData[i];
        // Fetch 4 images for the 2x2 collage grid (large size for sharp carousel)
        final result = await _pexelsService.searchPhotos(
          query: data['query'] as String,
          perPage: 4,
          size: 'large',
        );

        if (result.pins.isNotEmpty) {
          ideaBoards.add(IdeaBoard(
            id: 'board_$i',
            title: data['title'] as String,
            creator: data['creator'] as String,
            imageUrls: result.pins.map((p) => p.imageUrl).toList(),
            pinCount: data['pinCount'] as int,
            timeAgo: data['timeAgo'] as String,
            isVerified: data['isVerified'] as bool,
          ));
        }
      } catch (_) {
        // Skip failed boards
      }
    }

    state = state.copyWith(ideaBoards: ideaBoards);
  }

  Future<void> _loadPopularCategories() async {
    final categories = <DiscoverCategory>[];
    final categoryPins = <String, List<Pin>>{};

    for (int i = 0; i < _categoryData.length; i++) {
      try {
        final data = _categoryData[i];
        final result = await _pexelsService.searchPhotos(
          query: data['query']!,
          perPage: 6,
          size: 'large',
        );

        if (result.pins.isNotEmpty) {
          final categoryId = 'category_$i';
          categories.add(DiscoverCategory(
            id: categoryId,
            name: data['name']!,
            query: data['query']!,
            imageUrls: result.pins.map((p) => p.imageUrl).toList(),
          ));
          categoryPins[categoryId] = result.pins;
        }
      } catch (_) {
        // Skip failed categories
      }
    }

    state = state.copyWith(
      popularCategories: categories,
      categoryPins: categoryPins,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await Future.wait([
        _loadHeroItems(),
        _loadIdeaBoards(),
        _loadPopularCategories(),
      ]);

      state = state.copyWith(isLoading: false);
      _persistDiscoverCache();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to refresh discover content',
      );
    }
  }

  Future<List<Pin>> loadCategoryPins(String categoryId, String query) async {
    if (state.categoryPins.containsKey(categoryId)) {
      return state.categoryPins[categoryId]!;
    }

    try {
      final result = await _pexelsService.searchPhotos(
        query: query,
        perPage: 20,
      );

      final newCategoryPins = Map<String, List<Pin>>.from(state.categoryPins);
      newCategoryPins[categoryId] = result.pins;

      state = state.copyWith(categoryPins: newCategoryPins);
      return result.pins;
    } catch (_) {
      return [];
    }
  }
}

// Provider for discover state
final discoverProvider =
    StateNotifierProvider<DiscoverNotifier, DiscoverState>((ref) {
  return DiscoverNotifier(
    pexelsService: getIt<PexelsApiService>(),
    localStorage: getIt<LocalStorageService>(),
  );
});

// Selector providers for granular rebuilds
final discoverHeroItemsProvider = Provider<List<HeroItem>>((ref) {
  return ref.watch(discoverProvider.select((s) => s.heroItems));
});

final discoverIdeaBoardsProvider = Provider<List<IdeaBoard>>((ref) {
  return ref.watch(discoverProvider.select((s) => s.ideaBoards));
});

final discoverCategoriesProvider = Provider<List<DiscoverCategory>>((ref) {
  return ref.watch(discoverProvider.select((s) => s.popularCategories));
});

final discoverIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(discoverProvider.select((s) => s.isLoading));
});

final discoverErrorProvider = Provider<String?>((ref) {
  return ref.watch(discoverProvider.select((s) => s.error));
});

final discoverCategoryPinsProvider =
    Provider.family<List<Pin>, String>((ref, categoryId) {
  return ref.watch(
    discoverProvider.select((s) => s.categoryPins[categoryId] ?? []),
  );
});
