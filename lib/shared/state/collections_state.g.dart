// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionsStateImpl _$$CollectionsStateImplFromJson(
  Map<String, dynamic> json,
) => _$CollectionsStateImpl(
  boardsMap:
      (json['boardsMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Board.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  boardOrder:
      (json['boardOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  pinToBoardsMap:
      (json['pinToBoardsMap'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toSet()),
      ) ??
      const {},
  selectedBoardId: json['selectedBoardId'] as String?,
  recentBoardIds:
      (json['recentBoardIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isLoading: json['isLoading'] as bool? ?? false,
  isInitialized: json['isInitialized'] as bool? ?? false,
  error: json['error'] as String?,
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
  version: (json['version'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$CollectionsStateImplToJson(
  _$CollectionsStateImpl instance,
) => <String, dynamic>{
  'boardsMap': instance.boardsMap,
  'boardOrder': instance.boardOrder,
  'pinToBoardsMap': instance.pinToBoardsMap.map(
    (k, e) => MapEntry(k, e.toList()),
  ),
  'selectedBoardId': instance.selectedBoardId,
  'recentBoardIds': instance.recentBoardIds,
  'isLoading': instance.isLoading,
  'isInitialized': instance.isInitialized,
  'error': instance.error,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
  'version': instance.version,
};

_$CollectionsCacheDataImpl _$$CollectionsCacheDataImplFromJson(
  Map<String, dynamic> json,
) => _$CollectionsCacheDataImpl(
  boards: (json['boards'] as List<dynamic>)
      .map((e) => Board.fromJson(e as Map<String, dynamic>))
      .toList(),
  boardOrder: (json['boardOrder'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  recentBoardIds: (json['recentBoardIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  selectedBoardId: json['selectedBoardId'] as String?,
  cachedAt: DateTime.parse(json['cachedAt'] as String),
);

Map<String, dynamic> _$$CollectionsCacheDataImplToJson(
  _$CollectionsCacheDataImpl instance,
) => <String, dynamic>{
  'boards': instance.boards,
  'boardOrder': instance.boardOrder,
  'recentBoardIds': instance.recentBoardIds,
  'selectedBoardId': instance.selectedBoardId,
  'cachedAt': instance.cachedAt.toIso8601String(),
};
