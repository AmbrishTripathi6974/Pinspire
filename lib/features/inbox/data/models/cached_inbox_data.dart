// Cached inbox updates for instant load and better performance
// Persisted to local storage; shown when feed is not yet loaded

import 'package:pinterest/features/inbox/domain/entities/inbox_update.dart';

/// Single cached update item (serializable, no read state).
class CachedInboxUpdateItem {
  const CachedInboxUpdateItem({
    required this.pinId,
    required this.title,
    required this.imageUrl,
    required this.timeAgo,
  });

  final String pinId;
  final String title;
  final String imageUrl;
  final String timeAgo;

  Map<String, dynamic> toJson() => {
        'pinId': pinId,
        'title': title,
        'imageUrl': imageUrl,
        'timeAgo': timeAgo,
      };

  factory CachedInboxUpdateItem.fromJson(Map<String, dynamic> json) {
    return CachedInboxUpdateItem(
      pinId: json['pinId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      timeAgo: json['timeAgo'] as String? ?? '',
    );
  }

  /// Convert from [InboxUpdate] for persistence.
  static CachedInboxUpdateItem fromInboxUpdate(InboxUpdate u) {
    return CachedInboxUpdateItem(
      pinId: u.pinId,
      title: u.title,
      imageUrl: u.imageUrl,
      timeAgo: u.timeAgo,
    );
  }
}

/// Cached inbox updates list with timestamp.
class CachedInboxData {
  const CachedInboxData({
    required this.updates,
    required this.cachedAt,
  });

  final List<CachedInboxUpdateItem> updates;
  final DateTime cachedAt;

  Map<String, dynamic> toJson() => {
        'cachedAt': cachedAt.toIso8601String(),
        'updates': updates.map((e) => e.toJson()).toList(),
      };

  factory CachedInboxData.fromJson(Map<String, dynamic> json) {
    final updatesList = json['updates'] as List<dynamic>? ?? [];
    return CachedInboxData(
      cachedAt: json['cachedAt'] != null
          ? DateTime.tryParse(json['cachedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      updates: updatesList
          .map((e) => CachedInboxUpdateItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Whether this cache is still considered fresh (e.g. 15 minutes).
  bool get isFresh {
    const duration = Duration(minutes: 15);
    return DateTime.now().difference(cachedAt) < duration;
  }
}
