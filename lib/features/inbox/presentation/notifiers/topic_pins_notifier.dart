// Topic pins notifier - search by title with pagination
// Powers Update Topic page (title + masonry grid of related pins)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/search/domain/repositories/search_repository.dart';
import 'package:pinterest/features/inbox/presentation/state/topic_pins_state.dart';

/// Notifier for topic pins (search results by title).
/// Loads initial page on creation, supports load more.
class TopicPinsNotifier extends StateNotifier<TopicPinsState> {
  TopicPinsNotifier({
    required SearchRepository repository,
    required String title,
  })  : _repository = repository,
        _title = title,
        super(const TopicPinsState()) {
    loadInitial();
  }

  final SearchRepository _repository;
  final String _title;

  static const int _perPage = 15;

  Future<void> loadInitial() async {
    if (state.pins.isNotEmpty) return;

    state = state.copyWith(isInitialLoading: true, error: null);

    final result = await _repository.searchPins(
      query: _title,
      page: 1,
      perPage: _perPage,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isInitialLoading: false,
          error: failure.message,
          pins: [],
        );
      },
      (paginated) {
        state = state.copyWith(
          pins: paginated.pins,
          hasMore: paginated.hasNextPage,
          currentPage: paginated.page,
          isInitialLoading: false,
          error: null,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true, error: null);

    final nextPage = state.currentPage + 1;
    final result = await _repository.searchPins(
      query: _title,
      page: nextPage,
      perPage: _perPage,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingMore: false,
          error: failure.message,
        );
      },
      (paginated) {
        final existingIds = state.pins.map((p) => p.id).toSet();
        final newPins =
            paginated.pins.where((p) => !existingIds.contains(p.id)).toList();
        state = state.copyWith(
          pins: [...state.pins, ...newPins],
          hasMore: paginated.hasNextPage,
          currentPage: paginated.page,
          isLoadingMore: false,
          error: null,
        );
      },
    );
  }
}
