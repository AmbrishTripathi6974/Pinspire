// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedStateImpl _$$FeedStateImplFromJson(Map<String, dynamic> json) =>
    _$FeedStateImpl(
      pins:
          (json['pins'] as List<dynamic>?)
              ?.map((e) => Pin.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isInitialLoading: json['isInitialLoading'] as bool? ?? true,
      isLoadingMore: json['isLoadingMore'] as bool? ?? false,
      isRefreshing: json['isRefreshing'] as bool? ?? false,
      hasMore: json['hasMore'] as bool? ?? true,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
      perPage: (json['perPage'] as num?)?.toInt() ?? 15,
      totalResults: (json['totalResults'] as num?)?.toInt() ?? 0,
      error: json['error'] as String?,
      lastFetchTime: json['lastFetchTime'] == null
          ? null
          : DateTime.parse(json['lastFetchTime'] as String),
    );

Map<String, dynamic> _$$FeedStateImplToJson(_$FeedStateImpl instance) =>
    <String, dynamic>{
      'pins': instance.pins,
      'isInitialLoading': instance.isInitialLoading,
      'isLoadingMore': instance.isLoadingMore,
      'isRefreshing': instance.isRefreshing,
      'hasMore': instance.hasMore,
      'currentPage': instance.currentPage,
      'perPage': instance.perPage,
      'totalResults': instance.totalResults,
      'error': instance.error,
      'lastFetchTime': instance.lastFetchTime?.toIso8601String(),
    };

_$CachedFeedDataImpl _$$CachedFeedDataImplFromJson(Map<String, dynamic> json) =>
    _$CachedFeedDataImpl(
      pins: (json['pins'] as List<dynamic>)
          .map((e) => Pin.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
      totalResults: (json['totalResults'] as num).toInt(),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$$CachedFeedDataImplToJson(
  _$CachedFeedDataImpl instance,
) => <String, dynamic>{
  'pins': instance.pins,
  'currentPage': instance.currentPage,
  'hasMore': instance.hasMore,
  'totalResults': instance.totalResults,
  'cachedAt': instance.cachedAt.toIso8601String(),
};
