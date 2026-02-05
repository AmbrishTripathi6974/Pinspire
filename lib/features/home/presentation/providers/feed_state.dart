// ignore_for_file: invalid_annotation_target

// Feed state with Freezed
// Immutable state for home feed with pagination support

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

part 'feed_state.freezed.dart';
part 'feed_state.g.dart';

/// Immutable state for the home feed
///
/// Handles multiple loading states:
/// - [isInitialLoading]: First page load (shows full-screen loader)
/// - [isLoadingMore]: Pagination load (shows bottom spinner)
/// - [isRefreshing]: Pull-to-refresh (shows refresh indicator)
@freezed
class FeedState with _$FeedState {
  const FeedState._();

  const factory FeedState({
    /// List of pins in the feed
    @Default([]) List<Pin> pins,

    /// Whether the initial load is in progress
    @Default(true) bool isInitialLoading,

    /// Whether more items are being loaded (pagination)
    @Default(false) bool isLoadingMore,

    /// Whether a refresh is in progress
    @Default(false) bool isRefreshing,

    /// Whether there are more pages to load
    @Default(true) bool hasMore,

    /// Current page number (1-indexed)
    @Default(0) int currentPage,

    /// Number of items per page
    @Default(15) int perPage,

    /// Total results available (from API)
    @Default(0) int totalResults,

    /// Error message if any operation failed
    String? error,

    /// Timestamp of last successful fetch (for cache invalidation)
    DateTime? lastFetchTime,
  }) = _FeedState;

  factory FeedState.fromJson(Map<String, dynamic> json) =>
      _$FeedStateFromJson(json);

  /// Initial state for a fresh feed
  factory FeedState.initial() => const FeedState();

  // =========================================================================
  // Computed Properties
  // =========================================================================

  /// Whether any loading operation is in progress
  bool get isLoading => isInitialLoading || isLoadingMore || isRefreshing;

  /// Whether the feed has been loaded at least once
  bool get hasLoaded => currentPage > 0 && !isInitialLoading;

  /// Whether the feed is empty after loading
  bool get isEmpty => hasLoaded && pins.isEmpty;

  /// Whether there's an error to display
  bool get hasError => error != null;

  /// Number of pins in the feed
  int get pinCount => pins.length;

  /// Whether we can load more items
  bool get canLoadMore => hasMore && !isLoading;

  /// Whether the feed data is stale (older than 5 minutes)
  bool get isStale {
    if (lastFetchTime == null) return true;
    final staleThreshold = DateTime.now().subtract(const Duration(minutes: 5));
    return lastFetchTime!.isBefore(staleThreshold);
  }

  // =========================================================================
  // State Transition Helpers (for debugging)
  // =========================================================================

  /// Returns current loading state as a string
  String get loadingStateDescription {
    if (isInitialLoading) return 'initial_loading';
    if (isLoadingMore) return 'loading_more';
    if (isRefreshing) return 'refreshing';
    return 'idle';
  }
}

/// Cached feed data for persistence
///
/// Stores minimal data needed to restore feed state on app restart
@freezed
class CachedFeedData with _$CachedFeedData {
  const factory CachedFeedData({
    required List<Pin> pins,
    required int currentPage,
    required bool hasMore,
    required int totalResults,
    required DateTime cachedAt,
  }) = _CachedFeedData;

  factory CachedFeedData.fromJson(Map<String, dynamic> json) =>
      _$CachedFeedDataFromJson(json);
}
