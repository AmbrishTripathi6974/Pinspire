// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  coverImageUrl: json['cover_image_url'] as String?,
  pinIds:
      (json['pinIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isPrivate: json['isPrivate'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cover_image_url': instance.coverImageUrl,
      'pinIds': instance.pinIds,
      'isPrivate': instance.isPrivate,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
