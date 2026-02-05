// Feed StateNotifier with SharedPreferences persistence
// Manages home feed state with pagination and caching

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';
import 'package:pinterest/features/home/presentation/providers/feed_state.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// StateNotifier for home feed management
///
/// Features:
/// - Initial load on creation
/// - Pagination support (load more on scroll)
/// - Pull-to-refresh with stable UI
/// - Automatic state persistence to SharedPreferences
/// - State restoration on app restart
/// - Duplicate request prevention
class FeedNotifier extends StateNotifier<FeedState> {
  FeedNotifier({
    required FeedRepository feedRepository,
    required LocalStorageService localStorage,
  })  : _feedRepository = feedRepository,
        _localStorage = localStorage,
        super(FeedState.initial()) {
    _initialize();
  }

  final FeedRepository _feedRepository;
  final LocalStorageService _localStorage;

  /// Tracks ongoing requests to prevent duplicates
  Completer<void>? _loadingCompleter;
  Completer<void>? _refreshCompleter;

  /// Set when notifier is disposed; prevents state updates after dispose (avoids leaks/errors).
  bool _disposed = false;

  // =========================================================================
  // Initialization
  // =========================================================================

  /// Initializes the feed by loading cached data, then fetching fresh content.
  /// Optimized for fast initial load: shows cached data immediately even if stale,
  /// then refreshes in background if needed.
  Future<void> _initialize() async {
    // First, try to restore cached state (even if stale)
    final restored = await _restoreCachedState();

    if (restored) {
      // Show cached data immediately for fast initial load
      // Mark as not loading so UI can render cached content right away
      state = state.copyWith(isInitialLoading: false);
      
      // If cache is stale, refresh in background without blocking UI
      if (state.isStale) {
        // Refresh in background - don't await, let it happen asynchronously
        loadInitialPage().catchError((_) {
          // Silently handle errors - cached data is already shown
        });
      }
    } else {
      // No cache — load fresh data
      await loadInitialPage();
    }
  }

  // =========================================================================
  // Public API
  // =========================================================================

  /// Loads the initial page of the feed
  ///
  /// Shows full-screen loading indicator.
  /// Call this for first load or after error recovery.
  Future<void> loadInitialPage() async {
    // Prevent duplicate initial loads
    if (_loadingCompleter != null && !_loadingCompleter!.isCompleted) {
      return _loadingCompleter!.future;
    }

    _loadingCompleter = Completer<void>();

    try {
      state = state.copyWith(
        isInitialLoading: true,
        error: null,
      );

      final result = await _feedRepository.getHomePins(
        page: 1,
        perPage: state.perPage,
      );

      result.fold(
        (failure) {
          if (!_disposed) {
            state = state.copyWith(
              isInitialLoading: false,
              error: failure.message,
            );
          }
        },
        (paginatedResult) {
          if (!_disposed) {
            state = state.copyWith(
              pins: paginatedResult.pins,
              currentPage: paginatedResult.page,
              hasMore: paginatedResult.hasNextPage,
              totalResults: paginatedResult.totalResults,
              isInitialLoading: false,
              error: null,
              lastFetchTime: DateTime.now(),
            );
            _persistState();
          }
        },
      );
    } catch (e) {
      if (!_disposed) {
        state = state.copyWith(
          isInitialLoading: false,
          error: 'An unexpected error occurred',
        );
      }
    } finally {
      _loadingCompleter?.complete();
    }
  }

  /// Loads the next page of pins
  ///
  /// Shows bottom loading indicator.
  /// Automatically prevents duplicate calls and checks hasMore.
  Future<void> loadNextPage() async {
    // Guard conditions
    if (!state.canLoadMore) return;
    if (_loadingCompleter != null && !_loadingCompleter!.isCompleted) return;

    _loadingCompleter = Completer<void>();

    try {
      state = state.copyWith(
        isLoadingMore: true,
        error: null,
      );

      final nextPage = state.currentPage + 1;
      final result = await _feedRepository.getHomePins(
        page: nextPage,
        perPage: state.perPage,
      );

      result.fold(
        (failure) {
          if (!_disposed) {
            state = state.copyWith(
              isLoadingMore: false,
              error: failure.message,
            );
          }
        },
        (paginatedResult) {
          if (!_disposed) {
            // Deduplicate pins by ID before appending
            final existingIds = state.pins.map((p) => p.id).toSet();
            final newPins = paginatedResult.pins
                .where((p) => !existingIds.contains(p.id))
                .toList();
            
            if (newPins.isEmpty) {
              // No new pins, just update loading state
              state = state.copyWith(isLoadingMore: false);
              return;
            }
            
            final nextPage = paginatedResult.page;
            final hasNextPage = paginatedResult.hasNextPage;
            final totalResults = paginatedResult.totalResults;
            final currentPins = state.pins;
            
            // Use addPostFrameCallback for better performance - runs after current frame
            // This ensures smooth scrolling while loading more content
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_disposed && currentPins == state.pins) {
                // Use List.from for better performance with large lists
                final updatedPins = List<Pin>.from(currentPins)..addAll(newPins);
                state = state.copyWith(
                  pins: updatedPins,
                  currentPage: nextPage,
                  hasMore: hasNextPage,
                  totalResults: totalResults,
                  isLoadingMore: false,
                  error: null,
                  lastFetchTime: DateTime.now(),
                );
                // Persist state asynchronously to avoid blocking UI
                _persistState();
              } else if (!_disposed) {
                state = state.copyWith(isLoadingMore: false);
              }
            });
          }
        },
      );
    } catch (e) {
      if (!_disposed) {
        state = state.copyWith(
          isLoadingMore: false,
          error: 'Failed to load more pins',
        );
      }
    } finally {
      _loadingCompleter?.complete();
    }
  }

  /// Refreshes the feed (pull-to-refresh only). Called only from explicit user action.
  ///
  /// Not triggered by: tab switch, page rebuild, navigation back, or scroll.
  /// Behavior: clears cache, fetches fresh content, replaces on success, keeps existing on failure.
  Future<void> refresh() async {
    // Prevent duplicate refresh calls
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      return _refreshCompleter!.future;
    }

    // Don't refresh during initial load
    if (state.isInitialLoading) return;

    _refreshCompleter = Completer<void>();

    try {
      state = state.copyWith(
        isRefreshing: true,
        error: null,
      );

      // Clear the cache to ensure we get fresh content
      await clearCache();

      final result = await _feedRepository.refreshHomePins(
        perPage: state.perPage,
      );

      result.fold(
        (failure) {
          if (!_disposed) {
            state = state.copyWith(
              isRefreshing: false,
              // On refresh failure, keep existing data
              // Only show error if we had no data
              error: state.pins.isEmpty ? failure.message : null,
            );
          }
        },
        (paginatedResult) {
          if (!_disposed) {
            final newPins = List<Pin>.from(paginatedResult.pins);
            final hasNextPage = paginatedResult.hasNextPage;
            final totalResults = paginatedResult.totalResults;
            // Use addPostFrameCallback for better performance - runs after current frame
            // This ensures smooth refresh animation
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_disposed) {
                state = state.copyWith(
                  pins: newPins,
                  currentPage: 1,
                  hasMore: hasNextPage,
                  totalResults: totalResults,
                  isRefreshing: false,
                  error: null,
                  lastFetchTime: DateTime.now(),
                );
                // Persist state asynchronously to avoid blocking UI
                _persistState();
              }
            });
          }
        },
      );
    } catch (e) {
      if (!_disposed) {
        state = state.copyWith(
          isRefreshing: false,
          error: state.pins.isEmpty ? 'Failed to refresh feed' : null,
        );
      }
    } finally {
      _refreshCompleter?.complete();
    }
  }

  /// Retries the last failed operation
  Future<void> retry() async {
    clearError();
    if (state.currentPage == 0) {
      await loadInitialPage();
    } else {
      await refresh();
    }
  }

  /// Clears any displayed error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Updates a specific pin in the feed
  ///
  /// Used when like/save state changes
  void updatePin(Pin updatedPin) {
    final index = state.pins.indexWhere((p) => p.id == updatedPin.id);
    if (index == -1) return;

    final newPins = List<Pin>.from(state.pins);
    newPins[index] = updatedPin;
    state = state.copyWith(pins: newPins);
  }

  /// Updates like state for a pin
  void updatePinLikeState(String pinId, bool liked) {
    final index = state.pins.indexWhere((p) => p.id == pinId);
    if (index == -1) return;

    final pin = state.pins[index];
    updatePin(pin.copyWith(liked: liked));
  }

  /// Updates save state for a pin
  void updatePinSaveState(String pinId, bool saved) {
    final index = state.pins.indexWhere((p) => p.id == pinId);
    if (index == -1) return;

    final pin = state.pins[index];
    updatePin(pin.copyWith(saved: saved));
  }

  // =========================================================================
  // Persistence
  // =========================================================================

  /// Persists current state to SharedPreferences
  Future<void> _persistState() async {
    try {
      // Only cache first few pages to keep storage reasonable
      final pinsToCache = state.pins.take(45).toList();

      final cacheData = CachedFeedData(
        pins: pinsToCache,
        currentPage: state.currentPage > 3 ? 3 : state.currentPage,
        hasMore: state.hasMore,
        totalResults: state.totalResults,
        cachedAt: DateTime.now(),
      );

      await _localStorage.setJson(
        StorageKeys.feedCache,
        cacheData.toJson(),
      );
    } catch (_) {
      // Silently fail - persistence errors shouldn't affect UX
    }
  }

  /// Restores state from SharedPreferences
  ///
  /// Returns true if state was successfully restored
  /// Optimized: Restores cache even if stale for fast initial load
  Future<bool> _restoreCachedState() async {
    try {
      final cacheJson = _localStorage.getJson(StorageKeys.feedCache);
      if (cacheJson == null) return false;

      final cacheData = CachedFeedData.fromJson(cacheJson);

      // Restore cache even if stale - we'll refresh in background if needed
      // This ensures fast initial load by showing cached data immediately
      state = state.copyWith(
        pins: cacheData.pins,
        currentPage: cacheData.currentPage,
        hasMore: cacheData.hasMore,
        totalResults: cacheData.totalResults,
        lastFetchTime: cacheData.cachedAt,
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Clears cached feed data
  Future<void> clearCache() async {
    await _localStorage.remove(StorageKeys.feedCache);
  }

  // =========================================================================
  // Cleanup
  // =========================================================================

  @override
  void dispose() {
    _disposed = true;
    _loadingCompleter = null;
    _refreshCompleter = null;
    super.dispose();
  }
}
