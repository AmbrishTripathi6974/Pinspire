// Riverpod providers for feed state
// Manages home feed data and pagination

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';
import 'package:pinterest/features/home/presentation/providers/feed_state.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/shared/notifiers/feed_notifier.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

// =============================================================================
// Core Providers (Dependencies)
// =============================================================================

/// Provider for FeedRepository from get_it
final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return getIt<FeedRepository>();
});

// Note: Uses shared localStorageProvider from app_providers.dart

// =============================================================================
// Main Feed Provider
// =============================================================================

/// StateNotifierProvider for the home feed
///
/// Provides access to:
/// - Feed state (pins, loading states, errors)
/// - Feed notifier methods (loadNextPage, refresh, retry)
///
/// Example usage:
/// ```dart
/// // Read state
/// final feedState = ref.watch(feedProvider);
///
/// // Call methods
/// ref.read(feedProvider.notifier).loadNextPage();
/// ref.read(feedProvider.notifier).refresh();
/// ```
final feedProvider =
    StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  return FeedNotifier(
    feedRepository: ref.watch(feedRepositoryProvider),
    localStorage: ref.watch(userScopedStorageProvider),
  );
});

// =============================================================================
// Convenience Providers (Derived State)
// =============================================================================

/// Provider for the list of pins in the feed
///
/// Use this when you only need the pins list and want to avoid
/// rebuilds from other state changes.
final feedPinsProvider = Provider<List<Pin>>((ref) {
  return ref.watch(feedProvider.select((state) => state.pins));
});

/// Provider for initial loading state
///
/// Returns true only during the first load.
final feedIsInitialLoadingProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.isInitialLoading));
});

/// Provider for pagination loading state
///
/// Returns true when loading more items.
final feedIsLoadingMoreProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.isLoadingMore));
});

/// Provider for refresh state
///
/// Returns true during pull-to-refresh.
final feedIsRefreshingProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.isRefreshing));
});

/// Provider for any loading state
///
/// Returns true if any loading operation is in progress.
final feedIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.isLoading));
});

/// Provider for feed error state
///
/// Returns the error message if any, null otherwise.
final feedErrorProvider = Provider<String?>((ref) {
  return ref.watch(feedProvider.select((state) => state.error));
});

/// Provider for hasMore flag
///
/// Returns true if more pages are available.
final feedHasMoreProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.hasMore));
});

/// Provider for canLoadMore flag
///
/// Returns true if we can load more (hasMore && !isLoading).
final feedCanLoadMoreProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.canLoadMore));
});

/// Provider for feed pin count
///
/// Returns the number of pins in the feed.
final feedPinCountProvider = Provider<int>((ref) {
  return ref.watch(feedProvider.select((state) => state.pinCount));
});

/// Provider for empty feed state
///
/// Returns true if the feed is empty after loading.
final feedIsEmptyProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.isEmpty));
});

/// Provider for feed loaded state
///
/// Returns true if the feed has been loaded at least once.
final feedHasLoadedProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider.select((state) => state.hasLoaded));
});

/// Provider to get a specific pin by ID from the feed
///
/// Returns null if pin is not found.
final feedPinByIdProvider = Provider.family<Pin?, String>((ref, pinId) {
  final pins = ref.watch(feedPinsProvider);
  try {
    return pins.firstWhere((p) => p.id == pinId);
  } catch (_) {
    return null;
  }
});

/// Provider for feed statistics
///
/// Returns a map with feed metadata.
/// Uses selective watching to minimize rebuilds.
final feedStatsProvider = Provider<Map<String, dynamic>>((ref) {
  // Watch only the specific fields needed to avoid unnecessary rebuilds
  final pinCount = ref.watch(feedProvider.select((s) => s.pinCount));
  final currentPage = ref.watch(feedProvider.select((s) => s.currentPage));
  final totalResults = ref.watch(feedProvider.select((s) => s.totalResults));
  final hasMore = ref.watch(feedProvider.select((s) => s.hasMore));
  final isStale = ref.watch(feedProvider.select((s) => s.isStale));
  final loadingState = ref.watch(feedProvider.select((s) => s.loadingStateDescription));
  
  return {
    'pinCount': pinCount,
    'currentPage': currentPage,
    'totalResults': totalResults,
    'hasMore': hasMore,
    'isStale': isStale,
    'loadingState': loadingState,
  };
});

/// Provider for feed pins with saved state synchronized
///
/// This provider automatically syncs saved/liked state from savedPinsProvider
/// into feed pins, eliminating the need for manual synchronization in widgets.
/// This improves performance by moving state synchronization to the provider layer.
final feedPinsWithSavedStateProvider = Provider<List<Pin>>((ref) {
  final pins = ref.watch(feedPinsProvider);
  final savedPinIds = ref.watch(savedPinIdsProvider);
  final likedPinIds = ref.watch(likedPinIdsProvider);
  
  // Use memoization to avoid recreating list if nothing changed
  // Check if any pin needs updating
  final needsUpdate = pins.any((pin) => 
    pin.saved != savedPinIds.contains(pin.id) ||
    pin.liked != likedPinIds.contains(pin.id)
  );
  
  if (!needsUpdate) {
    return pins; // Return original list if no changes needed
  }
  
  // Create new list with updated saved/liked state
  return pins.map((pin) {
    final isSaved = savedPinIds.contains(pin.id);
    final isLiked = likedPinIds.contains(pin.id);
    
    if (pin.saved == isSaved && pin.liked == isLiked) {
      return pin; // Return original if no change
    }
    
    return pin.copyWith(saved: isSaved, liked: isLiked);
  }).toList();
});
