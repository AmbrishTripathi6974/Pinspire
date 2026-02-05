// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_pins_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedPinsStateImpl _$$SavedPinsStateImplFromJson(Map<String, dynamic> json) =>
    _$SavedPinsStateImpl(
      savedPinsMap:
          (json['savedPinsMap'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Pin.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      savedPinIds:
          (json['savedPinIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      likedPinIds:
          (json['likedPinIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      savedPinSourceQueries:
          (json['savedPinSourceQueries'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      isLoading: json['isLoading'] as bool? ?? false,
      isInitialized: json['isInitialized'] as bool? ?? false,
      error: json['error'] as String?,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      version: (json['version'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SavedPinsStateImplToJson(
  _$SavedPinsStateImpl instance,
) => <String, dynamic>{
  'savedPinsMap': instance.savedPinsMap,
  'savedPinIds': instance.savedPinIds.toList(),
  'likedPinIds': instance.likedPinIds.toList(),
  'savedPinSourceQueries': instance.savedPinSourceQueries,
  'isLoading': instance.isLoading,
  'isInitialized': instance.isInitialized,
  'error': instance.error,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
  'version': instance.version,
};

_$SavedPinsCacheDataImpl _$$SavedPinsCacheDataImplFromJson(
  Map<String, dynamic> json,
) => _$SavedPinsCacheDataImpl(
  pins: (json['pins'] as List<dynamic>)
      .map((e) => Pin.fromJson(e as Map<String, dynamic>))
      .toList(),
  savedPinIds: (json['savedPinIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  likedPinIds: (json['likedPinIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  savedPinSourceQueries:
      (json['savedPinSourceQueries'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  cachedAt: DateTime.parse(json['cachedAt'] as String),
);

Map<String, dynamic> _$$SavedPinsCacheDataImplToJson(
  _$SavedPinsCacheDataImpl instance,
) => <String, dynamic>{
  'pins': instance.pins,
  'savedPinIds': instance.savedPinIds,
  'likedPinIds': instance.likedPinIds,
  'savedPinSourceQueries': instance.savedPinSourceQueries,
  'cachedAt': instance.cachedAt.toIso8601String(),
};
