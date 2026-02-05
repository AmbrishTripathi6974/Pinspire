// Topic pins state - search results for an update title
// Used for Update Topic page (title + masonry grid)

import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// State for topic pins (search by title).
class TopicPinsState {
  const TopicPinsState({
    this.pins = const [],
    this.hasMore = true,
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 0,
  });

  final List<Pin> pins;
  final bool hasMore;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;

  TopicPinsState copyWith({
    List<Pin>? pins,
    bool? hasMore,
    bool? isInitialLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
  }) {
    return TopicPinsState(
      pins: pins ?? this.pins,
      hasMore: hasMore ?? this.hasMore,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
