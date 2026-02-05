// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_pins_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedPinsState _$SavedPinsStateFromJson(Map<String, dynamic> json) {
  return _SavedPinsState.fromJson(json);
}

/// @nodoc
mixin _$SavedPinsState {
  /// Map of saved pins by ID for O(1) access
  Map<String, Pin> get savedPinsMap => throw _privateConstructorUsedError;

  /// Set of saved pin IDs for quick lookup
  Set<String> get savedPinIds => throw _privateConstructorUsedError;

  /// Set of liked pin IDs
  Set<String> get likedPinIds => throw _privateConstructorUsedError;

  /// Pin ID -> search query when pin was saved from search (for "Ideas for you")
  Map<String, String> get savedPinSourceQueries =>
      throw _privateConstructorUsedError;

  /// Whether state is currently loading
  bool get isLoading => throw _privateConstructorUsedError;

  /// Whether initial load is complete
  bool get isInitialized => throw _privateConstructorUsedError;

  /// Error message if any
  String? get error => throw _privateConstructorUsedError;

  /// Last update timestamp for change detection
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Version counter for efficient rebuilds
  int get version => throw _privateConstructorUsedError;

  /// Serializes this SavedPinsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedPinsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedPinsStateCopyWith<SavedPinsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedPinsStateCopyWith<$Res> {
  factory $SavedPinsStateCopyWith(
    SavedPinsState value,
    $Res Function(SavedPinsState) then,
  ) = _$SavedPinsStateCopyWithImpl<$Res, SavedPinsState>;
  @useResult
  $Res call({
    Map<String, Pin> savedPinsMap,
    Set<String> savedPinIds,
    Set<String> likedPinIds,
    Map<String, String> savedPinSourceQueries,
    bool isLoading,
    bool isInitialized,
    String? error,
    DateTime? lastUpdated,
    int version,
  });
}

/// @nodoc
class _$SavedPinsStateCopyWithImpl<$Res, $Val extends SavedPinsState>
    implements $SavedPinsStateCopyWith<$Res> {
  _$SavedPinsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedPinsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedPinsMap = null,
    Object? savedPinIds = null,
    Object? likedPinIds = null,
    Object? savedPinSourceQueries = null,
    Object? isLoading = null,
    Object? isInitialized = null,
    Object? error = freezed,
    Object? lastUpdated = freezed,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            savedPinsMap: null == savedPinsMap
                ? _value.savedPinsMap
                : savedPinsMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, Pin>,
            savedPinIds: null == savedPinIds
                ? _value.savedPinIds
                : savedPinIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            likedPinIds: null == likedPinIds
                ? _value.likedPinIds
                : likedPinIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            savedPinSourceQueries: null == savedPinSourceQueries
                ? _value.savedPinSourceQueries
                : savedPinSourceQueries // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavedPinsStateImplCopyWith<$Res>
    implements $SavedPinsStateCopyWith<$Res> {
  factory _$$SavedPinsStateImplCopyWith(
    _$SavedPinsStateImpl value,
    $Res Function(_$SavedPinsStateImpl) then,
  ) = __$$SavedPinsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, Pin> savedPinsMap,
    Set<String> savedPinIds,
    Set<String> likedPinIds,
    Map<String, String> savedPinSourceQueries,
    bool isLoading,
    bool isInitialized,
    String? error,
    DateTime? lastUpdated,
    int version,
  });
}

/// @nodoc
class __$$SavedPinsStateImplCopyWithImpl<$Res>
    extends _$SavedPinsStateCopyWithImpl<$Res, _$SavedPinsStateImpl>
    implements _$$SavedPinsStateImplCopyWith<$Res> {
  __$$SavedPinsStateImplCopyWithImpl(
    _$SavedPinsStateImpl _value,
    $Res Function(_$SavedPinsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedPinsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedPinsMap = null,
    Object? savedPinIds = null,
    Object? likedPinIds = null,
    Object? savedPinSourceQueries = null,
    Object? isLoading = null,
    Object? isInitialized = null,
    Object? error = freezed,
    Object? lastUpdated = freezed,
    Object? version = null,
  }) {
    return _then(
      _$SavedPinsStateImpl(
        savedPinsMap: null == savedPinsMap
            ? _value._savedPinsMap
            : savedPinsMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, Pin>,
        savedPinIds: null == savedPinIds
            ? _value._savedPinIds
            : savedPinIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        likedPinIds: null == likedPinIds
            ? _value._likedPinIds
            : likedPinIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        savedPinSourceQueries: null == savedPinSourceQueries
            ? _value._savedPinSourceQueries
            : savedPinSourceQueries // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedPinsStateImpl extends _SavedPinsState {
  const _$SavedPinsStateImpl({
    final Map<String, Pin> savedPinsMap = const {},
    final Set<String> savedPinIds = const {},
    final Set<String> likedPinIds = const {},
    final Map<String, String> savedPinSourceQueries = const {},
    this.isLoading = false,
    this.isInitialized = false,
    this.error,
    this.lastUpdated,
    this.version = 0,
  }) : _savedPinsMap = savedPinsMap,
       _savedPinIds = savedPinIds,
       _likedPinIds = likedPinIds,
       _savedPinSourceQueries = savedPinSourceQueries,
       super._();

  factory _$SavedPinsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedPinsStateImplFromJson(json);

  /// Map of saved pins by ID for O(1) access
  final Map<String, Pin> _savedPinsMap;

  /// Map of saved pins by ID for O(1) access
  @override
  @JsonKey()
  Map<String, Pin> get savedPinsMap {
    if (_savedPinsMap is EqualUnmodifiableMapView) return _savedPinsMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_savedPinsMap);
  }

  /// Set of saved pin IDs for quick lookup
  final Set<String> _savedPinIds;

  /// Set of saved pin IDs for quick lookup
  @override
  @JsonKey()
  Set<String> get savedPinIds {
    if (_savedPinIds is EqualUnmodifiableSetView) return _savedPinIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_savedPinIds);
  }

  /// Set of liked pin IDs
  final Set<String> _likedPinIds;

  /// Set of liked pin IDs
  @override
  @JsonKey()
  Set<String> get likedPinIds {
    if (_likedPinIds is EqualUnmodifiableSetView) return _likedPinIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_likedPinIds);
  }

  /// Pin ID -> search query when pin was saved from search (for "Ideas for you")
  final Map<String, String> _savedPinSourceQueries;

  /// Pin ID -> search query when pin was saved from search (for "Ideas for you")
  @override
  @JsonKey()
  Map<String, String> get savedPinSourceQueries {
    if (_savedPinSourceQueries is EqualUnmodifiableMapView)
      return _savedPinSourceQueries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_savedPinSourceQueries);
  }

  /// Whether state is currently loading
  @override
  @JsonKey()
  final bool isLoading;

  /// Whether initial load is complete
  @override
  @JsonKey()
  final bool isInitialized;

  /// Error message if any
  @override
  final String? error;

  /// Last update timestamp for change detection
  @override
  final DateTime? lastUpdated;

  /// Version counter for efficient rebuilds
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'SavedPinsState(savedPinsMap: $savedPinsMap, savedPinIds: $savedPinIds, likedPinIds: $likedPinIds, savedPinSourceQueries: $savedPinSourceQueries, isLoading: $isLoading, isInitialized: $isInitialized, error: $error, lastUpdated: $lastUpdated, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedPinsStateImpl &&
            const DeepCollectionEquality().equals(
              other._savedPinsMap,
              _savedPinsMap,
            ) &&
            const DeepCollectionEquality().equals(
              other._savedPinIds,
              _savedPinIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._likedPinIds,
              _likedPinIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._savedPinSourceQueries,
              _savedPinSourceQueries,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_savedPinsMap),
    const DeepCollectionEquality().hash(_savedPinIds),
    const DeepCollectionEquality().hash(_likedPinIds),
    const DeepCollectionEquality().hash(_savedPinSourceQueries),
    isLoading,
    isInitialized,
    error,
    lastUpdated,
    version,
  );

  /// Create a copy of SavedPinsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedPinsStateImplCopyWith<_$SavedPinsStateImpl> get copyWith =>
      __$$SavedPinsStateImplCopyWithImpl<_$SavedPinsStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedPinsStateImplToJson(this);
  }
}

abstract class _SavedPinsState extends SavedPinsState {
  const factory _SavedPinsState({
    final Map<String, Pin> savedPinsMap,
    final Set<String> savedPinIds,
    final Set<String> likedPinIds,
    final Map<String, String> savedPinSourceQueries,
    final bool isLoading,
    final bool isInitialized,
    final String? error,
    final DateTime? lastUpdated,
    final int version,
  }) = _$SavedPinsStateImpl;
  const _SavedPinsState._() : super._();

  factory _SavedPinsState.fromJson(Map<String, dynamic> json) =
      _$SavedPinsStateImpl.fromJson;

  /// Map of saved pins by ID for O(1) access
  @override
  Map<String, Pin> get savedPinsMap;

  /// Set of saved pin IDs for quick lookup
  @override
  Set<String> get savedPinIds;

  /// Set of liked pin IDs
  @override
  Set<String> get likedPinIds;

  /// Pin ID -> search query when pin was saved from search (for "Ideas for you")
  @override
  Map<String, String> get savedPinSourceQueries;

  /// Whether state is currently loading
  @override
  bool get isLoading;

  /// Whether initial load is complete
  @override
  bool get isInitialized;

  /// Error message if any
  @override
  String? get error;

  /// Last update timestamp for change detection
  @override
  DateTime? get lastUpdated;

  /// Version counter for efficient rebuilds
  @override
  int get version;

  /// Create a copy of SavedPinsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedPinsStateImplCopyWith<_$SavedPinsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SavedPinsCacheData _$SavedPinsCacheDataFromJson(Map<String, dynamic> json) {
  return _SavedPinsCacheData.fromJson(json);
}

/// @nodoc
mixin _$SavedPinsCacheData {
  List<Pin> get pins => throw _privateConstructorUsedError;
  List<String> get savedPinIds => throw _privateConstructorUsedError;
  List<String> get likedPinIds => throw _privateConstructorUsedError;
  Map<String, String> get savedPinSourceQueries =>
      throw _privateConstructorUsedError;
  DateTime get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this SavedPinsCacheData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedPinsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedPinsCacheDataCopyWith<SavedPinsCacheData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedPinsCacheDataCopyWith<$Res> {
  factory $SavedPinsCacheDataCopyWith(
    SavedPinsCacheData value,
    $Res Function(SavedPinsCacheData) then,
  ) = _$SavedPinsCacheDataCopyWithImpl<$Res, SavedPinsCacheData>;
  @useResult
  $Res call({
    List<Pin> pins,
    List<String> savedPinIds,
    List<String> likedPinIds,
    Map<String, String> savedPinSourceQueries,
    DateTime cachedAt,
  });
}

/// @nodoc
class _$SavedPinsCacheDataCopyWithImpl<$Res, $Val extends SavedPinsCacheData>
    implements $SavedPinsCacheDataCopyWith<$Res> {
  _$SavedPinsCacheDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedPinsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? savedPinIds = null,
    Object? likedPinIds = null,
    Object? savedPinSourceQueries = null,
    Object? cachedAt = null,
  }) {
    return _then(
      _value.copyWith(
            pins: null == pins
                ? _value.pins
                : pins // ignore: cast_nullable_to_non_nullable
                      as List<Pin>,
            savedPinIds: null == savedPinIds
                ? _value.savedPinIds
                : savedPinIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            likedPinIds: null == likedPinIds
                ? _value.likedPinIds
                : likedPinIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            savedPinSourceQueries: null == savedPinSourceQueries
                ? _value.savedPinSourceQueries
                : savedPinSourceQueries // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
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
abstract class _$$SavedPinsCacheDataImplCopyWith<$Res>
    implements $SavedPinsCacheDataCopyWith<$Res> {
  factory _$$SavedPinsCacheDataImplCopyWith(
    _$SavedPinsCacheDataImpl value,
    $Res Function(_$SavedPinsCacheDataImpl) then,
  ) = __$$SavedPinsCacheDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Pin> pins,
    List<String> savedPinIds,
    List<String> likedPinIds,
    Map<String, String> savedPinSourceQueries,
    DateTime cachedAt,
  });
}

/// @nodoc
class __$$SavedPinsCacheDataImplCopyWithImpl<$Res>
    extends _$SavedPinsCacheDataCopyWithImpl<$Res, _$SavedPinsCacheDataImpl>
    implements _$$SavedPinsCacheDataImplCopyWith<$Res> {
  __$$SavedPinsCacheDataImplCopyWithImpl(
    _$SavedPinsCacheDataImpl _value,
    $Res Function(_$SavedPinsCacheDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedPinsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pins = null,
    Object? savedPinIds = null,
    Object? likedPinIds = null,
    Object? savedPinSourceQueries = null,
    Object? cachedAt = null,
  }) {
    return _then(
      _$SavedPinsCacheDataImpl(
        pins: null == pins
            ? _value._pins
            : pins // ignore: cast_nullable_to_non_nullable
                  as List<Pin>,
        savedPinIds: null == savedPinIds
            ? _value._savedPinIds
            : savedPinIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        likedPinIds: null == likedPinIds
            ? _value._likedPinIds
            : likedPinIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        savedPinSourceQueries: null == savedPinSourceQueries
            ? _value._savedPinSourceQueries
            : savedPinSourceQueries // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
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
class _$SavedPinsCacheDataImpl implements _SavedPinsCacheData {
  const _$SavedPinsCacheDataImpl({
    required final List<Pin> pins,
    required final List<String> savedPinIds,
    required final List<String> likedPinIds,
    final Map<String, String> savedPinSourceQueries = const {},
    required this.cachedAt,
  }) : _pins = pins,
       _savedPinIds = savedPinIds,
       _likedPinIds = likedPinIds,
       _savedPinSourceQueries = savedPinSourceQueries;

  factory _$SavedPinsCacheDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedPinsCacheDataImplFromJson(json);

  final List<Pin> _pins;
  @override
  List<Pin> get pins {
    if (_pins is EqualUnmodifiableListView) return _pins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pins);
  }

  final List<String> _savedPinIds;
  @override
  List<String> get savedPinIds {
    if (_savedPinIds is EqualUnmodifiableListView) return _savedPinIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedPinIds);
  }

  final List<String> _likedPinIds;
  @override
  List<String> get likedPinIds {
    if (_likedPinIds is EqualUnmodifiableListView) return _likedPinIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedPinIds);
  }

  final Map<String, String> _savedPinSourceQueries;
  @override
  @JsonKey()
  Map<String, String> get savedPinSourceQueries {
    if (_savedPinSourceQueries is EqualUnmodifiableMapView)
      return _savedPinSourceQueries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_savedPinSourceQueries);
  }

  @override
  final DateTime cachedAt;

  @override
  String toString() {
    return 'SavedPinsCacheData(pins: $pins, savedPinIds: $savedPinIds, likedPinIds: $likedPinIds, savedPinSourceQueries: $savedPinSourceQueries, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedPinsCacheDataImpl &&
            const DeepCollectionEquality().equals(other._pins, _pins) &&
            const DeepCollectionEquality().equals(
              other._savedPinIds,
              _savedPinIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._likedPinIds,
              _likedPinIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._savedPinSourceQueries,
              _savedPinSourceQueries,
            ) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pins),
    const DeepCollectionEquality().hash(_savedPinIds),
    const DeepCollectionEquality().hash(_likedPinIds),
    const DeepCollectionEquality().hash(_savedPinSourceQueries),
    cachedAt,
  );

  /// Create a copy of SavedPinsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedPinsCacheDataImplCopyWith<_$SavedPinsCacheDataImpl> get copyWith =>
      __$$SavedPinsCacheDataImplCopyWithImpl<_$SavedPinsCacheDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedPinsCacheDataImplToJson(this);
  }
}

abstract class _SavedPinsCacheData implements SavedPinsCacheData {
  const factory _SavedPinsCacheData({
    required final List<Pin> pins,
    required final List<String> savedPinIds,
    required final List<String> likedPinIds,
    final Map<String, String> savedPinSourceQueries,
    required final DateTime cachedAt,
  }) = _$SavedPinsCacheDataImpl;

  factory _SavedPinsCacheData.fromJson(Map<String, dynamic> json) =
      _$SavedPinsCacheDataImpl.fromJson;

  @override
  List<Pin> get pins;
  @override
  List<String> get savedPinIds;
  @override
  List<String> get likedPinIds;
  @override
  Map<String, String> get savedPinSourceQueries;
  @override
  DateTime get cachedAt;

  /// Create a copy of SavedPinsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedPinsCacheDataImplCopyWith<_$SavedPinsCacheDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
