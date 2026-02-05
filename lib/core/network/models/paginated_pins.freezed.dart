// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_pins.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedPins _$PaginatedPinsFromJson(Map<String, dynamic> json) {
  return _PaginatedPins.fromJson(json);
}

/// @nodoc
mixin _$PaginatedPins {
  /// List of pins for the current page
  List<Pin> get pins => throw _privateConstructorUsedError;

  /// Current page number (1-indexed)
  int get page => throw _privateConstructorUsedError;

  /// Number of items per page
  int get perPage => throw _privateConstructorUsedError;

  /// Total number of results available
  int get totalResults => throw _privateConstructorUsedError;

  /// Whether there are more pages available
  bool get hasNextPage => throw _privateConstructorUsedError;

  /// URL to fetch the next page (if available)
  String? get nextPageUrl => throw _privateConstructorUsedError;

  /// URL to fetch the previous page (if available)
  String? get prevPageUrl => throw _privateConstructorUsedError;

  /// Serializes this PaginatedPins to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedPins
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedPinsCopyWith<PaginatedPins> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedPinsCopyWith<$Res> {
  factory $PaginatedPinsCopyWith(
    PaginatedPins value,
    $Res Function(PaginatedPins) then,
  ) = _$PaginatedPinsCopyWithImpl<$Res, PaginatedPins>;
  @useResult
  $Res call({
    List<Pin> pins,
    int page,
    int perPage,
    int totalResults,
    bool hasNextPage,
    String? nextPageUrl,
    String? prevPageUrl,
  });
}

/// @nodoc
class _$PaginatedPinsCopyWithImpl<$Res, $Val extends PaginatedPins>
    implements $PaginatedPinsCopyWith<$Res> {
  _$PaginatedPinsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedPins
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? page = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? hasNextPage = null,
    Object? nextPageUrl = freezed,
    Object? prevPageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            pins: null == pins
                ? _value.pins
                : pins // ignore: cast_nullable_to_non_nullable
                      as List<Pin>,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalResults: null == totalResults
                ? _value.totalResults
                : totalResults // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNextPage: null == hasNextPage
                ? _value.hasNextPage
                : hasNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            nextPageUrl: freezed == nextPageUrl
                ? _value.nextPageUrl
                : nextPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevPageUrl: freezed == prevPageUrl
                ? _value.prevPageUrl
                : prevPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedPinsImplCopyWith<$Res>
    implements $PaginatedPinsCopyWith<$Res> {
  factory _$$PaginatedPinsImplCopyWith(
    _$PaginatedPinsImpl value,
    $Res Function(_$PaginatedPinsImpl) then,
  ) = __$$PaginatedPinsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Pin> pins,
    int page,
    int perPage,
    int totalResults,
    bool hasNextPage,
    String? nextPageUrl,
    String? prevPageUrl,
  });
}

/// @nodoc
class __$$PaginatedPinsImplCopyWithImpl<$Res>
    extends _$PaginatedPinsCopyWithImpl<$Res, _$PaginatedPinsImpl>
    implements _$$PaginatedPinsImplCopyWith<$Res> {
  __$$PaginatedPinsImplCopyWithImpl(
    _$PaginatedPinsImpl _value,
    $Res Function(_$PaginatedPinsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedPins
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? page = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? hasNextPage = null,
    Object? nextPageUrl = freezed,
    Object? prevPageUrl = freezed,
  }) {
    return _then(
      _$PaginatedPinsImpl(
        pins: null == pins
            ? _value._pins
            : pins // ignore: cast_nullable_to_non_nullable
                  as List<Pin>,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalResults: null == totalResults
            ? _value.totalResults
            : totalResults // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNextPage: null == hasNextPage
            ? _value.hasNextPage
            : hasNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevPageUrl: freezed == prevPageUrl
            ? _value.prevPageUrl
            : prevPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedPinsImpl extends _PaginatedPins {
  const _$PaginatedPinsImpl({
    required final List<Pin> pins,
    required this.page,
    required this.perPage,
    required this.totalResults,
    required this.hasNextPage,
    this.nextPageUrl,
    this.prevPageUrl,
  }) : _pins = pins,
       super._();

  factory _$PaginatedPinsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedPinsImplFromJson(json);

  /// List of pins for the current page
  final List<Pin> _pins;

  /// List of pins for the current page
  @override
  List<Pin> get pins {
    if (_pins is EqualUnmodifiableListView) return _pins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pins);
  }

  /// Current page number (1-indexed)
  @override
  final int page;

  /// Number of items per page
  @override
  final int perPage;

  /// Total number of results available
  @override
  final int totalResults;

  /// Whether there are more pages available
  @override
  final bool hasNextPage;

  /// URL to fetch the next page (if available)
  @override
  final String? nextPageUrl;

  /// URL to fetch the previous page (if available)
  @override
  final String? prevPageUrl;

  @override
  String toString() {
    return 'PaginatedPins(pins: $pins, page: $page, perPage: $perPage, totalResults: $totalResults, hasNextPage: $hasNextPage, nextPageUrl: $nextPageUrl, prevPageUrl: $prevPageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedPinsImpl &&
            const DeepCollectionEquality().equals(other._pins, _pins) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.prevPageUrl, prevPageUrl) ||
                other.prevPageUrl == prevPageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pins),
    page,
    perPage,
    totalResults,
    hasNextPage,
    nextPageUrl,
    prevPageUrl,
  );

  /// Create a copy of PaginatedPins
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedPinsImplCopyWith<_$PaginatedPinsImpl> get copyWith =>
      __$$PaginatedPinsImplCopyWithImpl<_$PaginatedPinsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedPinsImplToJson(this);
  }
}

abstract class _PaginatedPins extends PaginatedPins {
  const factory _PaginatedPins({
    required final List<Pin> pins,
    required final int page,
    required final int perPage,
    required final int totalResults,
    required final bool hasNextPage,
    final String? nextPageUrl,
    final String? prevPageUrl,
  }) = _$PaginatedPinsImpl;
  const _PaginatedPins._() : super._();

  factory _PaginatedPins.fromJson(Map<String, dynamic> json) =
      _$PaginatedPinsImpl.fromJson;

  /// List of pins for the current page
  @override
  List<Pin> get pins;

  /// Current page number (1-indexed)
  @override
  int get page;

  /// Number of items per page
  @override
  int get perPage;

  /// Total number of results available
  @override
  int get totalResults;

  /// Whether there are more pages available
  @override
  bool get hasNextPage;

  /// URL to fetch the next page (if available)
  @override
  String? get nextPageUrl;

  /// URL to fetch the previous page (if available)
  @override
  String? get prevPageUrl;

  /// Create a copy of PaginatedPins
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedPinsImplCopyWith<_$PaginatedPinsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
