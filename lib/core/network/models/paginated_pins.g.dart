// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_pins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedPinsImpl _$$PaginatedPinsImplFromJson(Map<String, dynamic> json) =>
    _$PaginatedPinsImpl(
      pins: (json['pins'] as List<dynamic>)
          .map((e) => Pin.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      totalResults: (json['totalResults'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      nextPageUrl: json['nextPageUrl'] as String?,
      prevPageUrl: json['prevPageUrl'] as String?,
    );

Map<String, dynamic> _$$PaginatedPinsImplToJson(_$PaginatedPinsImpl instance) =>
    <String, dynamic>{
      'pins': instance.pins,
      'page': instance.page,
      'perPage': instance.perPage,
      'totalResults': instance.totalResults,
      'hasNextPage': instance.hasNextPage,
      'nextPageUrl': instance.nextPageUrl,
      'prevPageUrl': instance.prevPageUrl,
    };
