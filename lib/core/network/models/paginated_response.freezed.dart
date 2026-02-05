// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaginatedResponse<T> {
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_results')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page')
  String? get nextPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_page')
  String? get prevPage => throw _privateConstructorUsedError;
  List<T> get photos => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResponseCopyWith<T, PaginatedResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResponseCopyWith<T, $Res> {
  factory $PaginatedResponseCopyWith(
    PaginatedResponse<T> value,
    $Res Function(PaginatedResponse<T>) then,
  ) = _$PaginatedResponseCopyWithImpl<T, $Res, PaginatedResponse<T>>;
  @useResult
  $Res call({
    int page,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'total_results') int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
    @JsonKey(name: 'prev_page') String? prevPage,
    List<T> photos,
  });
}

/// @nodoc
class _$PaginatedResponseCopyWithImpl<
  T,
  $Res,
  $Val extends PaginatedResponse<T>
>
    implements $PaginatedResponseCopyWith<T, $Res> {
  _$PaginatedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? nextPage = freezed,
    Object? prevPage = freezed,
    Object? photos = null,
  }) {
    return _then(
      _value.copyWith(
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
            nextPage: freezed == nextPage
                ? _value.nextPage
                : nextPage // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevPage: freezed == prevPage
                ? _value.prevPage
                : prevPage // ignore: cast_nullable_to_non_nullable
                      as String?,
            photos: null == photos
                ? _value.photos
                : photos // ignore: cast_nullable_to_non_nullable
                      as List<T>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedResponseImplCopyWith<T, $Res>
    implements $PaginatedResponseCopyWith<T, $Res> {
  factory _$$PaginatedResponseImplCopyWith(
    _$PaginatedResponseImpl<T> value,
    $Res Function(_$PaginatedResponseImpl<T>) then,
  ) = __$$PaginatedResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    int page,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'total_results') int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
    @JsonKey(name: 'prev_page') String? prevPage,
    List<T> photos,
  });
}

/// @nodoc
class __$$PaginatedResponseImplCopyWithImpl<T, $Res>
    extends _$PaginatedResponseCopyWithImpl<T, $Res, _$PaginatedResponseImpl<T>>
    implements _$$PaginatedResponseImplCopyWith<T, $Res> {
  __$$PaginatedResponseImplCopyWithImpl(
    _$PaginatedResponseImpl<T> _value,
    $Res Function(_$PaginatedResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? nextPage = freezed,
    Object? prevPage = freezed,
    Object? photos = null,
  }) {
    return _then(
      _$PaginatedResponseImpl<T>(
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
        nextPage: freezed == nextPage
            ? _value.nextPage
            : nextPage // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevPage: freezed == prevPage
            ? _value.prevPage
            : prevPage // ignore: cast_nullable_to_non_nullable
                  as String?,
        photos: null == photos
            ? _value._photos
            : photos // ignore: cast_nullable_to_non_nullable
                  as List<T>,
      ),
    );
  }
}

/// @nodoc

class _$PaginatedResponseImpl<T> extends _PaginatedResponse<T> {
  const _$PaginatedResponseImpl({
    required this.page,
    @JsonKey(name: 'per_page') required this.perPage,
    @JsonKey(name: 'total_results') required this.totalResults,
    @JsonKey(name: 'next_page') this.nextPage,
    @JsonKey(name: 'prev_page') this.prevPage,
    required final List<T> photos,
  }) : _photos = photos,
       super._();

  @override
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  @JsonKey(name: 'total_results')
  final int totalResults;
  @override
  @JsonKey(name: 'next_page')
  final String? nextPage;
  @override
  @JsonKey(name: 'prev_page')
  final String? prevPage;
  final List<T> _photos;
  @override
  List<T> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString() {
    return 'PaginatedResponse<$T>(page: $page, perPage: $perPage, totalResults: $totalResults, nextPage: $nextPage, prevPage: $prevPage, photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResponseImpl<T> &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.nextPage, nextPage) ||
                other.nextPage == nextPage) &&
            (identical(other.prevPage, prevPage) ||
                other.prevPage == prevPage) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    page,
    perPage,
    totalResults,
    nextPage,
    prevPage,
    const DeepCollectionEquality().hash(_photos),
  );

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResponseImplCopyWith<T, _$PaginatedResponseImpl<T>>
  get copyWith =>
      __$$PaginatedResponseImplCopyWithImpl<T, _$PaginatedResponseImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _PaginatedResponse<T> extends PaginatedResponse<T> {
  const factory _PaginatedResponse({
    required final int page,
    @JsonKey(name: 'per_page') required final int perPage,
    @JsonKey(name: 'total_results') required final int totalResults,
    @JsonKey(name: 'next_page') final String? nextPage,
    @JsonKey(name: 'prev_page') final String? prevPage,
    required final List<T> photos,
  }) = _$PaginatedResponseImpl<T>;
  const _PaginatedResponse._() : super._();

  @override
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'total_results')
  int get totalResults;
  @override
  @JsonKey(name: 'next_page')
  String? get nextPage;
  @override
  @JsonKey(name: 'prev_page')
  String? get prevPage;
  @override
  List<T> get photos;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResponseImplCopyWith<T, _$PaginatedResponseImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}

PaginatedPhotoResponse _$PaginatedPhotoResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedPhotoResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginatedPhotoResponse {
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_results')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page')
  String? get nextPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_page')
  String? get prevPage => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get photos => throw _privateConstructorUsedError;

  /// Serializes this PaginatedPhotoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedPhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedPhotoResponseCopyWith<PaginatedPhotoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedPhotoResponseCopyWith<$Res> {
  factory $PaginatedPhotoResponseCopyWith(
    PaginatedPhotoResponse value,
    $Res Function(PaginatedPhotoResponse) then,
  ) = _$PaginatedPhotoResponseCopyWithImpl<$Res, PaginatedPhotoResponse>;
  @useResult
  $Res call({
    int page,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'total_results') int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
    @JsonKey(name: 'prev_page') String? prevPage,
    List<Map<String, dynamic>> photos,
  });
}

/// @nodoc
class _$PaginatedPhotoResponseCopyWithImpl<
  $Res,
  $Val extends PaginatedPhotoResponse
>
    implements $PaginatedPhotoResponseCopyWith<$Res> {
  _$PaginatedPhotoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedPhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? nextPage = freezed,
    Object? prevPage = freezed,
    Object? photos = null,
  }) {
    return _then(
      _value.copyWith(
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
            nextPage: freezed == nextPage
                ? _value.nextPage
                : nextPage // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevPage: freezed == prevPage
                ? _value.prevPage
                : prevPage // ignore: cast_nullable_to_non_nullable
                      as String?,
            photos: null == photos
                ? _value.photos
                : photos // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedPhotoResponseImplCopyWith<$Res>
    implements $PaginatedPhotoResponseCopyWith<$Res> {
  factory _$$PaginatedPhotoResponseImplCopyWith(
    _$PaginatedPhotoResponseImpl value,
    $Res Function(_$PaginatedPhotoResponseImpl) then,
  ) = __$$PaginatedPhotoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'total_results') int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
    @JsonKey(name: 'prev_page') String? prevPage,
    List<Map<String, dynamic>> photos,
  });
}

/// @nodoc
class __$$PaginatedPhotoResponseImplCopyWithImpl<$Res>
    extends
        _$PaginatedPhotoResponseCopyWithImpl<$Res, _$PaginatedPhotoResponseImpl>
    implements _$$PaginatedPhotoResponseImplCopyWith<$Res> {
  __$$PaginatedPhotoResponseImplCopyWithImpl(
    _$PaginatedPhotoResponseImpl _value,
    $Res Function(_$PaginatedPhotoResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedPhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? nextPage = freezed,
    Object? prevPage = freezed,
    Object? photos = null,
  }) {
    return _then(
      _$PaginatedPhotoResponseImpl(
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
        nextPage: freezed == nextPage
            ? _value.nextPage
            : nextPage // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevPage: freezed == prevPage
            ? _value.prevPage
            : prevPage // ignore: cast_nullable_to_non_nullable
                  as String?,
        photos: null == photos
            ? _value._photos
            : photos // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedPhotoResponseImpl extends _PaginatedPhotoResponse {
  const _$PaginatedPhotoResponseImpl({
    required this.page,
    @JsonKey(name: 'per_page') required this.perPage,
    @JsonKey(name: 'total_results') required this.totalResults,
    @JsonKey(name: 'next_page') this.nextPage,
    @JsonKey(name: 'prev_page') this.prevPage,
    required final List<Map<String, dynamic>> photos,
  }) : _photos = photos,
       super._();

  factory _$PaginatedPhotoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedPhotoResponseImplFromJson(json);

  @override
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  @JsonKey(name: 'total_results')
  final int totalResults;
  @override
  @JsonKey(name: 'next_page')
  final String? nextPage;
  @override
  @JsonKey(name: 'prev_page')
  final String? prevPage;
  final List<Map<String, dynamic>> _photos;
  @override
  List<Map<String, dynamic>> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString() {
    return 'PaginatedPhotoResponse(page: $page, perPage: $perPage, totalResults: $totalResults, nextPage: $nextPage, prevPage: $prevPage, photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedPhotoResponseImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.nextPage, nextPage) ||
                other.nextPage == nextPage) &&
            (identical(other.prevPage, prevPage) ||
                other.prevPage == prevPage) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    page,
    perPage,
    totalResults,
    nextPage,
    prevPage,
    const DeepCollectionEquality().hash(_photos),
  );

  /// Create a copy of PaginatedPhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedPhotoResponseImplCopyWith<_$PaginatedPhotoResponseImpl>
  get copyWith =>
      __$$PaginatedPhotoResponseImplCopyWithImpl<_$PaginatedPhotoResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedPhotoResponseImplToJson(this);
  }
}

abstract class _PaginatedPhotoResponse extends PaginatedPhotoResponse {
  const factory _PaginatedPhotoResponse({
    required final int page,
    @JsonKey(name: 'per_page') required final int perPage,
    @JsonKey(name: 'total_results') required final int totalResults,
    @JsonKey(name: 'next_page') final String? nextPage,
    @JsonKey(name: 'prev_page') final String? prevPage,
    required final List<Map<String, dynamic>> photos,
  }) = _$PaginatedPhotoResponseImpl;
  const _PaginatedPhotoResponse._() : super._();

  factory _PaginatedPhotoResponse.fromJson(Map<String, dynamic> json) =
      _$PaginatedPhotoResponseImpl.fromJson;

  @override
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'total_results')
  int get totalResults;
  @override
  @JsonKey(name: 'next_page')
  String? get nextPage;
  @override
  @JsonKey(name: 'prev_page')
  String? get prevPage;
  @override
  List<Map<String, dynamic>> get photos;

  /// Create a copy of PaginatedPhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedPhotoResponseImplCopyWith<_$PaginatedPhotoResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
