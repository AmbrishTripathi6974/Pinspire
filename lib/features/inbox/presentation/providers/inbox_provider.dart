// Inbox providers - Updates list from feed + cache + read/hidden state
// Cache for instant load and better performance when opening Inbox

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/inbox/data/models/cached_inbox_data.dart';
import 'package:pinterest/features/inbox/domain/entities/inbox_update.dart';
import 'package:pinterest/features/inbox/presentation/notifiers/inbox_notifier.dart';
import 'package:pinterest/features/inbox/presentation/state/inbox_state.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

/// Max number of updates to show (Pinterest-style cap).
const int _maxUpdatesCount = 25;

/// Provider for inbox read/hidden state notifier.
final inboxNotifierProvider =
    StateNotifierProvider<InboxNotifier, InboxState>((ref) {
  return InboxNotifier(localStorage: ref.watch(localStorageProvider));
});

/// Provider for cached inbox updates (from local storage).
/// Used for instant display when feed is not yet loaded.
final inboxCacheProvider = Provider<CachedInboxData?>((ref) {
  final storage = ref.watch(localStorageProvider);
  final json = storage.getJson(StorageKeys.inboxUpdatesCache);
  if (json == null) return null;
  try {
    return CachedInboxData.fromJson(json);
  } catch (_) {
    return null;
  }
});

/// Provider for the list of InboxUpdate items built from feed.
/// Filtered by hidden, with read state from [inboxNotifierProvider].
/// Persist to cache when this list is non-empty (see Inbox page ref.listen).
final inboxUpdatesProvider = Provider<List<InboxUpdate>>((ref) {
  final pins = ref.watch(feedPinsProvider);
  final inboxState = ref.watch(inboxNotifierProvider);

  final updates = <InboxUpdate>[];
  final take = pins.length.clamp(0, _maxUpdatesCount);

  for (var i = 0; i < take; i++) {
    final pin = pins[i];
    if (inboxState.hiddenUpdateIds.contains(pin.id)) continue;
    final isUnread = !inboxState.readUpdateIds.contains(pin.id);
    updates.add(InboxUpdate.fromPin(pin, i, isUnread: isUnread));
  }

  return updates;
});

/// Display updates: feed-based when available, else cached for instant load.
/// Applies read/hidden state to cached items when showing cache.
final inboxDisplayUpdatesProvider = Provider<List<InboxUpdate>>((ref) {
  final pins = ref.watch(feedPinsProvider);
  final feedBasedUpdates = ref.watch(inboxUpdatesProvider);
  final cached = ref.watch(inboxCacheProvider);
  final inboxState = ref.watch(inboxNotifierProvider);

  // Prefer feed-based when we have pins (fresh data).
  if (pins.isNotEmpty && feedBasedUpdates.isNotEmpty) {
    return feedBasedUpdates;
  }

  // Fall back to cache for instant display while feed loads.
  if (cached != null && cached.updates.isNotEmpty) {
    return cached.updates
        .where((e) => !inboxState.hiddenUpdateIds.contains(e.pinId))
        .map(
          (e) => InboxUpdate(
            pinId: e.pinId,
            title: e.title,
            imageUrl: e.imageUrl,
            timeAgo: e.timeAgo,
            isUnread: !inboxState.readUpdateIds.contains(e.pinId),
          ),
        )
        .toList();
  }

  return [];
});

/// Whether display is currently showing cached data (vs feed).
/// Useful for optional "Last updated X min ago" or refresh hint.
final inboxIsShowingCacheProvider = Provider<bool>((ref) {
  final pins = ref.watch(feedPinsProvider);
  final feedBasedUpdates = ref.watch(inboxUpdatesProvider);
  return pins.isEmpty || feedBasedUpdates.isEmpty;
});

/// True when there is at least one unread update (for inbox tab badge).
final inboxHasUnreadUpdatesProvider = Provider<bool>((ref) {
  final updates = ref.watch(inboxDisplayUpdatesProvider);
  return updates.any((u) => u.isUnread);
});
