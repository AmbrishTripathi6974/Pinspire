// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PinImpl _$$PinImplFromJson(Map<String, dynamic> json) => _$PinImpl(
  id: const _IdConverter().fromJson(json['id']),
  imageUrl: const _ImageUrlConverter().fromJson(json['src']),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  photographer: json['photographer'] as String? ?? 'Unknown',
  description: json['alt'] as String?,
  liked: json['liked'] as bool? ?? false,
  saved: json['saved'] as bool? ?? false,
);

Map<String, dynamic> _$$PinImplToJson(_$PinImpl instance) => <String, dynamic>{
  'id': const _IdConverter().toJson(instance.id),
  'src': const _ImageUrlConverter().toJson(instance.imageUrl),
  'width': instance.width,
  'height': instance.height,
  'photographer': instance.photographer,
  'alt': instance.description,
  'liked': instance.liked,
  'saved': instance.saved,
};
