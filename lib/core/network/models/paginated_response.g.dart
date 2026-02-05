// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedPhotoResponseImpl _$$PaginatedPhotoResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedPhotoResponseImpl(
  page: (json['page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
  nextPage: json['next_page'] as String?,
  prevPage: json['prev_page'] as String?,
  photos: (json['photos'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
);

Map<String, dynamic> _$$PaginatedPhotoResponseImplToJson(
  _$PaginatedPhotoResponseImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'per_page': instance.perPage,
  'total_results': instance.totalResults,
  'next_page': instance.nextPage,
  'prev_page': instance.prevPage,
  'photos': instance.photos,
};
