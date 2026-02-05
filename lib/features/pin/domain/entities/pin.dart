// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin.freezed.dart';
part 'pin.g.dart';

@freezed
class Pin with _$Pin {
  const Pin._();

  const factory Pin({
    @_IdConverter() required String id,
    @JsonKey(name: 'src') @_ImageUrlConverter() required String imageUrl,
    required int width,
    required int height,
    @Default('Unknown') String photographer,
    @JsonKey(name: 'alt') String? description,
    @Default(false) bool liked,
    @Default(false) bool saved,
  }) = _Pin;

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);

  double get aspectRatio => height > 0 ? width / height : 1.0;

  Map<String, dynamic> toMap() => toJson();

  static Pin fromMap(Map<String, dynamic> map) => Pin.fromJson(map);
}

class _IdConverter implements JsonConverter<String, dynamic> {
  const _IdConverter();

  @override
  String fromJson(dynamic json) {
    if (json is String) return json;
    if (json is int) return json.toString();
    return json?.toString() ?? '';
  }

  @override
  dynamic toJson(String object) => object;
}

class _ImageUrlConverter implements JsonConverter<String, dynamic> {
  const _ImageUrlConverter();

  @override
  String fromJson(dynamic json) {
    if (json is String) return json;
    if (json is Map<String, dynamic>) {
      return json['original'] as String? ??
          json['large2x'] as String? ??
          json['large'] as String? ??
          json['medium'] as String? ??
          '';
    }

    return '';
  }

  @override
  dynamic toJson(String object) => object;
}
