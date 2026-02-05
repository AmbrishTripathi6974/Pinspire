// Discover screen models
// Hero carousel items, discovery categories, and idea boards

import 'package:flutter/foundation.dart';

/// Hero carousel item for editorial content
@immutable
class HeroItem {
  const HeroItem({
    required this.id,
    required this.imageUrl,
    required this.subtitle,
    required this.headline,
  });

  final String id;
  final String imageUrl;
  final String subtitle;
  final String headline;

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'subtitle': subtitle,
        'headline': headline,
      };

  factory HeroItem.fromJson(Map<String, dynamic> json) => HeroItem(
        id: json['id'] as String,
        imageUrl: json['imageUrl'] as String,
        subtitle: json['subtitle'] as String,
        headline: json['headline'] as String,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Discovery category for "Popular on Pinterest" sections
@immutable
class DiscoverCategory {
  const DiscoverCategory({
    required this.id,
    required this.name,
    required this.query,
    required this.imageUrls,
    this.isVerified = false,
  });

  final String id;
  final String name;
  final String query;
  final List<String> imageUrls;
  final bool isVerified;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'query': query,
        'imageUrls': imageUrls,
        'isVerified': isVerified,
      };

  factory DiscoverCategory.fromJson(Map<String, dynamic> json) =>
      DiscoverCategory(
        id: json['id'] as String,
        name: json['name'] as String,
        query: json['query'] as String,
        imageUrls: (json['imageUrls'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        isVerified: json['isVerified'] as bool? ?? false,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Idea board card for "Ideas you might like" section
@immutable
class IdeaBoard {
  const IdeaBoard({
    required this.id,
    required this.title,
    required this.creator,
    required this.imageUrls,
    required this.pinCount,
    required this.timeAgo,
    this.isVerified = false,
  });

  final String id;
  final String title;
  final String creator;
  final List<String> imageUrls; // Changed to list for 2x2 collage
  final int pinCount;
  final String timeAgo;
  final bool isVerified;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'creator': creator,
        'imageUrls': imageUrls,
        'pinCount': pinCount,
        'timeAgo': timeAgo,
        'isVerified': isVerified,
      };

  factory IdeaBoard.fromJson(Map<String, dynamic> json) => IdeaBoard(
        id: json['id'] as String,
        title: json['title'] as String,
        creator: json['creator'] as String,
        imageUrls: (json['imageUrls'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        pinCount: json['pinCount'] as int,
        timeAgo: json['timeAgo'] as String,
        isVerified: json['isVerified'] as bool? ?? false,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaBoard &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Recent search item
@immutable
class RecentSearch {
  const RecentSearch({
    required this.query,
    required this.timestamp,
    this.imageUrl,
  });

  final String query;
  final DateTime timestamp;
  final String? imageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSearch &&
          runtimeType == other.runtimeType &&
          query == other.query;

  @override
  int get hashCode => query.hashCode;
}

/// Trending search item
@immutable
class TrendingSearch {
  const TrendingSearch({
    required this.query,
    required this.imageUrl,
    this.rank,
  });

  final String query;
  final String imageUrl;
  final int? rank;

  Map<String, dynamic> toJson() => {
        'query': query,
        'imageUrl': imageUrl,
        if (rank != null) 'rank': rank,
      };

  factory TrendingSearch.fromJson(Map<String, dynamic> json) => TrendingSearch(
        query: json['query'] as String,
        imageUrl: json['imageUrl'] as String,
        rank: json['rank'] as int?,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendingSearch &&
          runtimeType == other.runtimeType &&
          query == other.query;

  @override
  int get hashCode => query.hashCode;
}
