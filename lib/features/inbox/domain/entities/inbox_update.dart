// Inbox update entity - represents one update (e.g. from followed user's new pin)
// Used for Updates list; real data can come from feed or activity API

import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// Single item in the Inbox Updates list.
/// Built from [Pin] with display title, relative time, and read state.
class InboxUpdate {
  const InboxUpdate({
    required this.pinId,
    required this.title,
    required this.imageUrl,
    required this.timeAgo,
    this.isUnread = true,
  });

  final String pinId;
  final String title;
  final String imageUrl;
  final String timeAgo;
  final bool isUnread;

  /// Build an [InboxUpdate] from a [Pin] and index (for timeAgo variety).
  static InboxUpdate fromPin(Pin pin, int index, {bool isUnread = true}) {
    final title = pin.description != null && pin.description!.isNotEmpty
        ? pin.description!
        : 'New pin for you';
    final timeAgo = index < 2 ? '2d' : '3w';
    return InboxUpdate(
      pinId: pin.id,
      title: title.length > 50 ? '${title.substring(0, 50)}…' : title,
      imageUrl: pin.imageUrl,
      timeAgo: timeAgo,
      isUnread: isUnread,
    );
  }
}
