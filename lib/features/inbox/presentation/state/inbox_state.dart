// Inbox state - read and hidden update IDs
// Persisted to local storage; used to derive Updates list

import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_state.freezed.dart';

/// Immutable state for inbox read/hidden state.
@freezed
class InboxState with _$InboxState {
  const factory InboxState({
    @Default({}) Set<String> readUpdateIds,
    @Default({}) Set<String> hiddenUpdateIds,
  }) = _InboxState;
}
