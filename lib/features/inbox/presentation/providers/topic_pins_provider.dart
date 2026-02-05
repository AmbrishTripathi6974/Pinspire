// Topic pins provider - search by title (family)
// Used by Update Topic page

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/features/search/domain/repositories/search_repository.dart';
import 'package:pinterest/features/inbox/presentation/notifiers/topic_pins_notifier.dart';
import 'package:pinterest/features/inbox/presentation/state/topic_pins_state.dart';

/// Provider for SearchRepository (from get_it).
final _searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return getIt<SearchRepository>();
});

/// Topic pins by title (search results).
/// Family parameter is the topic title; creates notifier per title.
final topicPinsProvider =
    StateNotifierProvider.family<TopicPinsNotifier, TopicPinsState, String>(
  (ref, title) {
    return TopicPinsNotifier(
      repository: ref.watch(_searchRepositoryProvider),
      title: title.isNotEmpty ? title : 'ideas',
    );
  },
);
