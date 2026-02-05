// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Pin _$PinFromJson(Map<String, dynamic> json) {
  return _Pin.fromJson(json);
}

/// @nodoc
mixin _$Pin {
  @_IdConverter()
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'src')
  @_ImageUrlConverter()
  String get imageUrl => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  String get photographer => throw _privateConstructorUsedError;
  @JsonKey(name: 'alt')
  String? get description => throw _privateConstructorUsedError;
  bool get liked => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;

  /// Serializes this Pin to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PinCopyWith<Pin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinCopyWith<$Res> {
  factory $PinCopyWith(Pin value, $Res Function(Pin) then) =
      _$PinCopyWithImpl<$Res, Pin>;
  @useResult
  $Res call({
    @_IdConverter() String id,
    @JsonKey(name: 'src') @_ImageUrlConverter() String imageUrl,
    int width,
    int height,
    String photographer,
    @JsonKey(name: 'alt') String? description,
    bool liked,
    bool saved,
  });
}

/// @nodoc
class _$PinCopyWithImpl<$Res, $Val extends Pin> implements $PinCopyWith<$Res> {
  _$PinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? width = null,
    Object? height = null,
    Object? photographer = null,
    Object? description = freezed,
    Object? liked = null,
    Object? saved = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int,
            photographer: null == photographer
                ? _value.photographer
                : photographer // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            liked: null == liked
                ? _value.liked
                : liked // ignore: cast_nullable_to_non_nullable
                      as bool,
            saved: null == saved
                ? _value.saved
                : saved // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PinImplCopyWith<$Res> implements $PinCopyWith<$Res> {
  factory _$$PinImplCopyWith(_$PinImpl value, $Res Function(_$PinImpl) then) =
      __$$PinImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @_IdConverter() String id,
    @JsonKey(name: 'src') @_ImageUrlConverter() String imageUrl,
    int width,
    int height,
    String photographer,
    @JsonKey(name: 'alt') String? description,
    bool liked,
    bool saved,
  });
}

/// @nodoc
class __$$PinImplCopyWithImpl<$Res> extends _$PinCopyWithImpl<$Res, _$PinImpl>
    implements _$$PinImplCopyWith<$Res> {
  __$$PinImplCopyWithImpl(_$PinImpl _value, $Res Function(_$PinImpl) _then)
    : super(_value, _then);

  /// Create a copy of Pin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? width = null,
    Object? height = null,
    Object? photographer = null,
    Object? description = freezed,
    Object? liked = null,
    Object? saved = null,
  }) {
    return _then(
      _$PinImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
        photographer: null == photographer
            ? _value.photographer
            : photographer // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        liked: null == liked
            ? _value.liked
            : liked // ignore: cast_nullable_to_non_nullable
                  as bool,
        saved: null == saved
            ? _value.saved
            : saved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PinImpl extends _Pin {
  const _$PinImpl({
    @_IdConverter() required this.id,
    @JsonKey(name: 'src') @_ImageUrlConverter() required this.imageUrl,
    required this.width,
    required this.height,
    this.photographer = 'Unknown',
    @JsonKey(name: 'alt') this.description,
    this.liked = false,
    this.saved = false,
  }) : super._();

  factory _$PinImpl.fromJson(Map<String, dynamic> json) =>
      _$$PinImplFromJson(json);

  @override
  @_IdConverter()
  final String id;
  @override
  @JsonKey(name: 'src')
  @_ImageUrlConverter()
  final String imageUrl;
  @override
  final int width;
  @override
  final int height;
  @override
  @JsonKey()
  final String photographer;
  @override
  @JsonKey(name: 'alt')
  final String? description;
  @override
  @JsonKey()
  final bool liked;
  @override
  @JsonKey()
  final bool saved;

  @override
  String toString() {
    return 'Pin(id: $id, imageUrl: $imageUrl, width: $width, height: $height, photographer: $photographer, description: $description, liked: $liked, saved: $saved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PinImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.photographer, photographer) ||
                other.photographer == photographer) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.liked, liked) || other.liked == liked) &&
            (identical(other.saved, saved) || other.saved == saved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    imageUrl,
    width,
    height,
    photographer,
    description,
    liked,
    saved,
  );

  /// Create a copy of Pin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PinImplCopyWith<_$PinImpl> get copyWith =>
      __$$PinImplCopyWithImpl<_$PinImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PinImplToJson(this);
  }
}

abstract class _Pin extends Pin {
  const factory _Pin({
    @_IdConverter() required final String id,
    @JsonKey(name: 'src') @_ImageUrlConverter() required final String imageUrl,
    required final int width,
    required final int height,
    final String photographer,
    @JsonKey(name: 'alt') final String? description,
    final bool liked,
    final bool saved,
  }) = _$PinImpl;
  const _Pin._() : super._();

  factory _Pin.fromJson(Map<String, dynamic> json) = _$PinImpl.fromJson;

  @override
  @_IdConverter()
  String get id;
  @override
  @JsonKey(name: 'src')
  @_ImageUrlConverter()
  String get imageUrl;
  @override
  int get width;
  @override
  int get height;
  @override
  String get photographer;
  @override
  @JsonKey(name: 'alt')
  String? get description;
  @override
  bool get liked;
  @override
  bool get saved;

  /// Create a copy of Pin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PinImplCopyWith<_$PinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
