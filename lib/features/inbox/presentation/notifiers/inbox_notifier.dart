// Inbox notifier - read/hidden state for Updates
// Persists to local storage; used with feed to build Updates list

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/inbox/presentation/state/inbox_state.dart';

/// Notifier for inbox read/hidden state.
/// Loads and persists read/hidden update IDs to local storage.
class InboxNotifier extends StateNotifier<InboxState> {
  InboxNotifier({
    required LocalStorageService localStorage,
  })  : _localStorage = localStorage,
        super(const InboxState()) {
    _loadPersistedState();
  }

  final LocalStorageService _localStorage;

  void _loadPersistedState() {
    final readIds =
        _localStorage.getStringList(StorageKeys.inboxReadUpdateIds)?.toSet() ??
            {};
    final hiddenIds =
        _localStorage.getStringList(StorageKeys.inboxHiddenUpdateIds)?.toSet() ??
            {};
    state = InboxState(readUpdateIds: readIds, hiddenUpdateIds: hiddenIds);
  }

  Future<void> _persistState() async {
    await _localStorage.setStringList(
      StorageKeys.inboxReadUpdateIds,
      state.readUpdateIds.toList(),
    );
    await _localStorage.setStringList(
      StorageKeys.inboxHiddenUpdateIds,
      state.hiddenUpdateIds.toList(),
    );
  }

  /// Mark an update as read (removes red dot).
  Future<void> markAsRead(String pinId) async {
    if (state.readUpdateIds.contains(pinId)) return;
    state = state.copyWith(
      readUpdateIds: {...state.readUpdateIds, pinId},
    );
    await _persistState();
  }

  /// Hide an update from the list (Pinterest-style "Hide this update").
  Future<void> hideUpdate(String pinId) async {
    if (state.hiddenUpdateIds.contains(pinId)) return;
    state = state.copyWith(
      hiddenUpdateIds: {...state.hiddenUpdateIds, pinId},
    );
    await _persistState();
  }

  /// Check if an update is read.
  bool isRead(String pinId) => state.readUpdateIds.contains(pinId);

  /// Check if an update is hidden.
  bool isHidden(String pinId) => state.hiddenUpdateIds.contains(pinId);
}
