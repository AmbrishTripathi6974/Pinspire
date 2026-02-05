// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FeedState _$FeedStateFromJson(Map<String, dynamic> json) {
  return _FeedState.fromJson(json);
}

/// @nodoc
mixin _$FeedState {
  /// List of pins in the feed
  List<Pin> get pins => throw _privateConstructorUsedError;

  /// Whether the initial load is in progress
  bool get isInitialLoading => throw _privateConstructorUsedError;

  /// Whether more items are being loaded (pagination)
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// Whether a refresh is in progress
  bool get isRefreshing => throw _privateConstructorUsedError;

  /// Whether there are more pages to load
  bool get hasMore => throw _privateConstructorUsedError;

  /// Current page number (1-indexed)
  int get currentPage => throw _privateConstructorUsedError;

  /// Number of items per page
  int get perPage => throw _privateConstructorUsedError;

  /// Total results available (from API)
  int get totalResults => throw _privateConstructorUsedError;

  /// Error message if any operation failed
  String? get error => throw _privateConstructorUsedError;

  /// Timestamp of last successful fetch (for cache invalidation)
  DateTime? get lastFetchTime => throw _privateConstructorUsedError;

  /// Serializes this FeedState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedStateCopyWith<FeedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedStateCopyWith<$Res> {
  factory $FeedStateCopyWith(FeedState value, $Res Function(FeedState) then) =
      _$FeedStateCopyWithImpl<$Res, FeedState>;
  @useResult
  $Res call({
    List<Pin> pins,
    bool isInitialLoading,
    bool isLoadingMore,
    bool isRefreshing,
    bool hasMore,
    int currentPage,
    int perPage,
    int totalResults,
    String? error,
    DateTime? lastFetchTime,
  });
}

/// @nodoc
class _$FeedStateCopyWithImpl<$Res, $Val extends FeedState>
    implements $FeedStateCopyWith<$Res> {
  _$FeedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? isInitialLoading = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? error = freezed,
    Object? lastFetchTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            pins: null == pins
                ? _value.pins
                : pins // ignore: cast_nullable_to_non_nullable
                      as List<Pin>,
            isInitialLoading: null == isInitialLoading
                ? _value.isInitialLoading
                : isInitialLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRefreshing: null == isRefreshing
                ? _value.isRefreshing
                : isRefreshing // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalResults: null == totalResults
                ? _value.totalResults
                : totalResults // ignore: cast_nullable_to_non_nullable
                      as int,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastFetchTime: freezed == lastFetchTime
                ? _value.lastFetchTime
                : lastFetchTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeedStateImplCopyWith<$Res>
    implements $FeedStateCopyWith<$Res> {
  factory _$$FeedStateImplCopyWith(
    _$FeedStateImpl value,
    $Res Function(_$FeedStateImpl) then,
  ) = __$$FeedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Pin> pins,
    bool isInitialLoading,
    bool isLoadingMore,
    bool isRefreshing,
    bool hasMore,
    int currentPage,
    int perPage,
    int totalResults,
    String? error,
    DateTime? lastFetchTime,
  });
}

/// @nodoc
class __$$FeedStateImplCopyWithImpl<$Res>
    extends _$FeedStateCopyWithImpl<$Res, _$FeedStateImpl>
    implements _$$FeedStateImplCopyWith<$Res> {
  __$$FeedStateImplCopyWithImpl(
    _$FeedStateImpl _value,
    $Res Function(_$FeedStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? isInitialLoading = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalResults = null,
    Object? error = freezed,
    Object? lastFetchTime = freezed,
  }) {
    return _then(
      _$FeedStateImpl(
        pins: null == pins
            ? _value._pins
            : pins // ignore: cast_nullable_to_non_nullable
                  as List<Pin>,
        isInitialLoading: null == isInitialLoading
            ? _value.isInitialLoading
            : isInitialLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalResults: null == totalResults
            ? _value.totalResults
            : totalResults // ignore: cast_nullable_to_non_nullable
                  as int,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastFetchTime: freezed == lastFetchTime
            ? _value.lastFetchTime
            : lastFetchTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedStateImpl extends _FeedState {
  const _$FeedStateImpl({
    final List<Pin> pins = const [],
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.perPage = 15,
    this.totalResults = 0,
    this.error,
    this.lastFetchTime,
  }) : _pins = pins,
       super._();

  factory _$FeedStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedStateImplFromJson(json);

  /// List of pins in the feed
  final List<Pin> _pins;

  /// List of pins in the feed
  @override
  @JsonKey()
  List<Pin> get pins {
    if (_pins is EqualUnmodifiableListView) return _pins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pins);
  }

  /// Whether the initial load is in progress
  @override
  @JsonKey()
  final bool isInitialLoading;

  /// Whether more items are being loaded (pagination)
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// Whether a refresh is in progress
  @override
  @JsonKey()
  final bool isRefreshing;

  /// Whether there are more pages to load
  @override
  @JsonKey()
  final bool hasMore;

  /// Current page number (1-indexed)
  @override
  @JsonKey()
  final int currentPage;

  /// Number of items per page
  @override
  @JsonKey()
  final int perPage;

  /// Total results available (from API)
  @override
  @JsonKey()
  final int totalResults;

  /// Error message if any operation failed
  @override
  final String? error;

  /// Timestamp of last successful fetch (for cache invalidation)
  @override
  final DateTime? lastFetchTime;

  @override
  String toString() {
    return 'FeedState(pins: $pins, isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, hasMore: $hasMore, currentPage: $currentPage, perPage: $perPage, totalResults: $totalResults, error: $error, lastFetchTime: $lastFetchTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedStateImpl &&
            const DeepCollectionEquality().equals(other._pins, _pins) &&
            (identical(other.isInitialLoading, isInitialLoading) ||
                other.isInitialLoading == isInitialLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastFetchTime, lastFetchTime) ||
                other.lastFetchTime == lastFetchTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pins),
    isInitialLoading,
    isLoadingMore,
    isRefreshing,
    hasMore,
    currentPage,
    perPage,
    totalResults,
    error,
    lastFetchTime,
  );

  /// Create a copy of FeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedStateImplCopyWith<_$FeedStateImpl> get copyWith =>
      __$$FeedStateImplCopyWithImpl<_$FeedStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedStateImplToJson(this);
  }
}

abstract class _FeedState extends FeedState {
  const factory _FeedState({
    final List<Pin> pins,
    final bool isInitialLoading,
    final bool isLoadingMore,
    final bool isRefreshing,
    final bool hasMore,
    final int currentPage,
    final int perPage,
    final int totalResults,
    final String? error,
    final DateTime? lastFetchTime,
  }) = _$FeedStateImpl;
  const _FeedState._() : super._();

  factory _FeedState.fromJson(Map<String, dynamic> json) =
      _$FeedStateImpl.fromJson;

  /// List of pins in the feed
  @override
  List<Pin> get pins;

  /// Whether the initial load is in progress
  @override
  bool get isInitialLoading;

  /// Whether more items are being loaded (pagination)
  @override
  bool get isLoadingMore;

  /// Whether a refresh is in progress
  @override
  bool get isRefreshing;

  /// Whether there are more pages to load
  @override
  bool get hasMore;

  /// Current page number (1-indexed)
  @override
  int get currentPage;

  /// Number of items per page
  @override
  int get perPage;

  /// Total results available (from API)
  @override
  int get totalResults;

  /// Error message if any operation failed
  @override
  String? get error;

  /// Timestamp of last successful fetch (for cache invalidation)
  @override
  DateTime? get lastFetchTime;

  /// Create a copy of FeedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedStateImplCopyWith<_$FeedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CachedFeedData _$CachedFeedDataFromJson(Map<String, dynamic> json) {
  return _CachedFeedData.fromJson(json);
}

/// @nodoc
mixin _$CachedFeedData {
  List<Pin> get pins => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;
  DateTime get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this CachedFeedData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CachedFeedData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CachedFeedDataCopyWith<CachedFeedData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CachedFeedDataCopyWith<$Res> {
  factory $CachedFeedDataCopyWith(
    CachedFeedData value,
    $Res Function(CachedFeedData) then,
  ) = _$CachedFeedDataCopyWithImpl<$Res, CachedFeedData>;
  @useResult
  $Res call({
    List<Pin> pins,
    int currentPage,
    bool hasMore,
    int totalResults,
    DateTime cachedAt,
  });
}

/// @nodoc
class _$CachedFeedDataCopyWithImpl<$Res, $Val extends CachedFeedData>
    implements $CachedFeedDataCopyWith<$Res> {
  _$CachedFeedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CachedFeedData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? totalResults = null,
    Object? cachedAt = null,
  }) {
    return _then(
      _value.copyWith(
            pins: null == pins
                ? _value.pins
                : pins // ignore: cast_nullable_to_non_nullable
                      as List<Pin>,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalResults: null == totalResults
                ? _value.totalResults
                : totalResults // ignore: cast_nullable_to_non_nullable
                      as int,
            cachedAt: null == cachedAt
                ? _value.cachedAt
                : cachedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CachedFeedDataImplCopyWith<$Res>
    implements $CachedFeedDataCopyWith<$Res> {
  factory _$$CachedFeedDataImplCopyWith(
    _$CachedFeedDataImpl value,
    $Res Function(_$CachedFeedDataImpl) then,
  ) = __$$CachedFeedDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Pin> pins,
    int currentPage,
    bool hasMore,
    int totalResults,
    DateTime cachedAt,
  });
}

/// @nodoc
class __$$CachedFeedDataImplCopyWithImpl<$Res>
    extends _$CachedFeedDataCopyWithImpl<$Res, _$CachedFeedDataImpl>
    implements _$$CachedFeedDataImplCopyWith<$Res> {
  __$$CachedFeedDataImplCopyWithImpl(
    _$CachedFeedDataImpl _value,
    $Res Function(_$CachedFeedDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CachedFeedData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? totalResults = null,
    Object? cachedAt = null,
  }) {
    return _then(
      _$CachedFeedDataImpl(
        pins: null == pins
            ? _value._pins
            : pins // ignore: cast_nullable_to_non_nullable
                  as List<Pin>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalResults: null == totalResults
            ? _value.totalResults
            : totalResults // ignore: cast_nullable_to_non_nullable
                  as int,
        cachedAt: null == cachedAt
            ? _value.cachedAt
            : cachedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CachedFeedDataImpl implements _CachedFeedData {
  const _$CachedFeedDataImpl({
    required final List<Pin> pins,
    required this.currentPage,
    required this.hasMore,
    required this.totalResults,
    required this.cachedAt,
  }) : _pins = pins;

  factory _$CachedFeedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CachedFeedDataImplFromJson(json);

  final List<Pin> _pins;
  @override
  List<Pin> get pins {
    if (_pins is EqualUnmodifiableListView) return _pins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pins);
  }

  @override
  final int currentPage;
  @override
  final bool hasMore;
  @override
  final int totalResults;
  @override
  final DateTime cachedAt;

  @override
  String toString() {
    return 'CachedFeedData(pins: $pins, currentPage: $currentPage, hasMore: $hasMore, totalResults: $totalResults, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CachedFeedDataImpl &&
            const DeepCollectionEquality().equals(other._pins, _pins) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pins),
    currentPage,
    hasMore,
    totalResults,
    cachedAt,
  );

  /// Create a copy of CachedFeedData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CachedFeedDataImplCopyWith<_$CachedFeedDataImpl> get copyWith =>
      __$$CachedFeedDataImplCopyWithImpl<_$CachedFeedDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CachedFeedDataImplToJson(this);
  }
}

abstract class _CachedFeedData implements CachedFeedData {
  const factory _CachedFeedData({
    required final List<Pin> pins,
    required final int currentPage,
    required final bool hasMore,
    required final int totalResults,
    required final DateTime cachedAt,
  }) = _$CachedFeedDataImpl;

  factory _CachedFeedData.fromJson(Map<String, dynamic> json) =
      _$CachedFeedDataImpl.fromJson;

  @override
  List<Pin> get pins;
  @override
  int get currentPage;
  @override
  bool get hasMore;
  @override
  int get totalResults;
  @override
  DateTime get cachedAt;

  /// Create a copy of CachedFeedData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CachedFeedDataImplCopyWith<_$CachedFeedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
