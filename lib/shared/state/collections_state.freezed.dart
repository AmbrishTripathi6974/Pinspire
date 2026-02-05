// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collections_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CollectionsState _$CollectionsStateFromJson(Map<String, dynamic> json) {
  return _CollectionsState.fromJson(json);
}

/// @nodoc
mixin _$CollectionsState {
  /// Map of boards by ID for O(1) access
  Map<String, Board> get boardsMap => throw _privateConstructorUsedError;

  /// Ordered list of board IDs (for display order)
  List<String> get boardOrder => throw _privateConstructorUsedError;

  /// Map of pin IDs to board IDs (for reverse lookup)
  Map<String, Set<String>> get pinToBoardsMap =>
      throw _privateConstructorUsedError;

  /// Currently selected board ID
  String? get selectedBoardId => throw _privateConstructorUsedError;

  /// Recently used board IDs (for quick access)
  List<String> get recentBoardIds => throw _privateConstructorUsedError;

  /// Whether state is currently loading
  bool get isLoading => throw _privateConstructorUsedError;

  /// Whether initial load is complete
  bool get isInitialized => throw _privateConstructorUsedError;

  /// Error message if any
  String? get error => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Version counter for efficient rebuilds
  int get version => throw _privateConstructorUsedError;

  /// Serializes this CollectionsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionsStateCopyWith<CollectionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionsStateCopyWith<$Res> {
  factory $CollectionsStateCopyWith(
    CollectionsState value,
    $Res Function(CollectionsState) then,
  ) = _$CollectionsStateCopyWithImpl<$Res, CollectionsState>;
  @useResult
  $Res call({
    Map<String, Board> boardsMap,
    List<String> boardOrder,
    Map<String, Set<String>> pinToBoardsMap,
    String? selectedBoardId,
    List<String> recentBoardIds,
    bool isLoading,
    bool isInitialized,
    String? error,
    DateTime? lastUpdated,
    int version,
  });
}

/// @nodoc
class _$CollectionsStateCopyWithImpl<$Res, $Val extends CollectionsState>
    implements $CollectionsStateCopyWith<$Res> {
  _$CollectionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardsMap = null,
    Object? boardOrder = null,
    Object? pinToBoardsMap = null,
    Object? selectedBoardId = freezed,
    Object? recentBoardIds = null,
    Object? isLoading = null,
    Object? isInitialized = null,
    Object? error = freezed,
    Object? lastUpdated = freezed,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            boardsMap: null == boardsMap
                ? _value.boardsMap
                : boardsMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, Board>,
            boardOrder: null == boardOrder
                ? _value.boardOrder
                : boardOrder // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pinToBoardsMap: null == pinToBoardsMap
                ? _value.pinToBoardsMap
                : pinToBoardsMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, Set<String>>,
            selectedBoardId: freezed == selectedBoardId
                ? _value.selectedBoardId
                : selectedBoardId // ignore: cast_nullable_to_non_nullable
                      as String?,
            recentBoardIds: null == recentBoardIds
                ? _value.recentBoardIds
                : recentBoardIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$CollectionsStateImplCopyWith<$Res>
    implements $CollectionsStateCopyWith<$Res> {
  factory _$$CollectionsStateImplCopyWith(
    _$CollectionsStateImpl value,
    $Res Function(_$CollectionsStateImpl) then,
  ) = __$$CollectionsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, Board> boardsMap,
    List<String> boardOrder,
    Map<String, Set<String>> pinToBoardsMap,
    String? selectedBoardId,
    List<String> recentBoardIds,
    bool isLoading,
    bool isInitialized,
    String? error,
    DateTime? lastUpdated,
    int version,
  });
}

/// @nodoc
class __$$CollectionsStateImplCopyWithImpl<$Res>
    extends _$CollectionsStateCopyWithImpl<$Res, _$CollectionsStateImpl>
    implements _$$CollectionsStateImplCopyWith<$Res> {
  __$$CollectionsStateImplCopyWithImpl(
    _$CollectionsStateImpl _value,
    $Res Function(_$CollectionsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CollectionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardsMap = null,
    Object? boardOrder = null,
    Object? pinToBoardsMap = null,
    Object? selectedBoardId = freezed,
    Object? recentBoardIds = null,
    Object? isLoading = null,
    Object? isInitialized = null,
    Object? error = freezed,
    Object? lastUpdated = freezed,
    Object? version = null,
  }) {
    return _then(
      _$CollectionsStateImpl(
        boardsMap: null == boardsMap
            ? _value._boardsMap
            : boardsMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, Board>,
        boardOrder: null == boardOrder
            ? _value._boardOrder
            : boardOrder // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pinToBoardsMap: null == pinToBoardsMap
            ? _value._pinToBoardsMap
            : pinToBoardsMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, Set<String>>,
        selectedBoardId: freezed == selectedBoardId
            ? _value.selectedBoardId
            : selectedBoardId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recentBoardIds: null == recentBoardIds
            ? _value._recentBoardIds
            : recentBoardIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
class _$CollectionsStateImpl extends _CollectionsState {
  const _$CollectionsStateImpl({
    final Map<String, Board> boardsMap = const {},
    final List<String> boardOrder = const [],
    final Map<String, Set<String>> pinToBoardsMap = const {},
    this.selectedBoardId,
    final List<String> recentBoardIds = const [],
    this.isLoading = false,
    this.isInitialized = false,
    this.error,
    this.lastUpdated,
    this.version = 0,
  }) : _boardsMap = boardsMap,
       _boardOrder = boardOrder,
       _pinToBoardsMap = pinToBoardsMap,
       _recentBoardIds = recentBoardIds,
       super._();

  factory _$CollectionsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionsStateImplFromJson(json);

  /// Map of boards by ID for O(1) access
  final Map<String, Board> _boardsMap;

  /// Map of boards by ID for O(1) access
  @override
  @JsonKey()
  Map<String, Board> get boardsMap {
    if (_boardsMap is EqualUnmodifiableMapView) return _boardsMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_boardsMap);
  }

  /// Ordered list of board IDs (for display order)
  final List<String> _boardOrder;

  /// Ordered list of board IDs (for display order)
  @override
  @JsonKey()
  List<String> get boardOrder {
    if (_boardOrder is EqualUnmodifiableListView) return _boardOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boardOrder);
  }

  /// Map of pin IDs to board IDs (for reverse lookup)
  final Map<String, Set<String>> _pinToBoardsMap;

  /// Map of pin IDs to board IDs (for reverse lookup)
  @override
  @JsonKey()
  Map<String, Set<String>> get pinToBoardsMap {
    if (_pinToBoardsMap is EqualUnmodifiableMapView) return _pinToBoardsMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pinToBoardsMap);
  }

  /// Currently selected board ID
  @override
  final String? selectedBoardId;

  /// Recently used board IDs (for quick access)
  final List<String> _recentBoardIds;

  /// Recently used board IDs (for quick access)
  @override
  @JsonKey()
  List<String> get recentBoardIds {
    if (_recentBoardIds is EqualUnmodifiableListView) return _recentBoardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentBoardIds);
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

  /// Last update timestamp
  @override
  final DateTime? lastUpdated;

  /// Version counter for efficient rebuilds
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'CollectionsState(boardsMap: $boardsMap, boardOrder: $boardOrder, pinToBoardsMap: $pinToBoardsMap, selectedBoardId: $selectedBoardId, recentBoardIds: $recentBoardIds, isLoading: $isLoading, isInitialized: $isInitialized, error: $error, lastUpdated: $lastUpdated, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionsStateImpl &&
            const DeepCollectionEquality().equals(
              other._boardsMap,
              _boardsMap,
            ) &&
            const DeepCollectionEquality().equals(
              other._boardOrder,
              _boardOrder,
            ) &&
            const DeepCollectionEquality().equals(
              other._pinToBoardsMap,
              _pinToBoardsMap,
            ) &&
            (identical(other.selectedBoardId, selectedBoardId) ||
                other.selectedBoardId == selectedBoardId) &&
            const DeepCollectionEquality().equals(
              other._recentBoardIds,
              _recentBoardIds,
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
    const DeepCollectionEquality().hash(_boardsMap),
    const DeepCollectionEquality().hash(_boardOrder),
    const DeepCollectionEquality().hash(_pinToBoardsMap),
    selectedBoardId,
    const DeepCollectionEquality().hash(_recentBoardIds),
    isLoading,
    isInitialized,
    error,
    lastUpdated,
    version,
  );

  /// Create a copy of CollectionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionsStateImplCopyWith<_$CollectionsStateImpl> get copyWith =>
      __$$CollectionsStateImplCopyWithImpl<_$CollectionsStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionsStateImplToJson(this);
  }
}

abstract class _CollectionsState extends CollectionsState {
  const factory _CollectionsState({
    final Map<String, Board> boardsMap,
    final List<String> boardOrder,
    final Map<String, Set<String>> pinToBoardsMap,
    final String? selectedBoardId,
    final List<String> recentBoardIds,
    final bool isLoading,
    final bool isInitialized,
    final String? error,
    final DateTime? lastUpdated,
    final int version,
  }) = _$CollectionsStateImpl;
  const _CollectionsState._() : super._();

  factory _CollectionsState.fromJson(Map<String, dynamic> json) =
      _$CollectionsStateImpl.fromJson;

  /// Map of boards by ID for O(1) access
  @override
  Map<String, Board> get boardsMap;

  /// Ordered list of board IDs (for display order)
  @override
  List<String> get boardOrder;

  /// Map of pin IDs to board IDs (for reverse lookup)
  @override
  Map<String, Set<String>> get pinToBoardsMap;

  /// Currently selected board ID
  @override
  String? get selectedBoardId;

  /// Recently used board IDs (for quick access)
  @override
  List<String> get recentBoardIds;

  /// Whether state is currently loading
  @override
  bool get isLoading;

  /// Whether initial load is complete
  @override
  bool get isInitialized;

  /// Error message if any
  @override
  String? get error;

  /// Last update timestamp
  @override
  DateTime? get lastUpdated;

  /// Version counter for efficient rebuilds
  @override
  int get version;

  /// Create a copy of CollectionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionsStateImplCopyWith<_$CollectionsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CollectionsCacheData _$CollectionsCacheDataFromJson(Map<String, dynamic> json) {
  return _CollectionsCacheData.fromJson(json);
}

/// @nodoc
mixin _$CollectionsCacheData {
  List<Board> get boards => throw _privateConstructorUsedError;
  List<String> get boardOrder => throw _privateConstructorUsedError;
  List<String> get recentBoardIds => throw _privateConstructorUsedError;
  String? get selectedBoardId => throw _privateConstructorUsedError;
  DateTime get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this CollectionsCacheData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionsCacheDataCopyWith<CollectionsCacheData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionsCacheDataCopyWith<$Res> {
  factory $CollectionsCacheDataCopyWith(
    CollectionsCacheData value,
    $Res Function(CollectionsCacheData) then,
  ) = _$CollectionsCacheDataCopyWithImpl<$Res, CollectionsCacheData>;
  @useResult
  $Res call({
    List<Board> boards,
    List<String> boardOrder,
    List<String> recentBoardIds,
    String? selectedBoardId,
    DateTime cachedAt,
  });
}

/// @nodoc
class _$CollectionsCacheDataCopyWithImpl<
  $Res,
  $Val extends CollectionsCacheData
>
    implements $CollectionsCacheDataCopyWith<$Res> {
  _$CollectionsCacheDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boards = null,
    Object? boardOrder = null,
    Object? recentBoardIds = null,
    Object? selectedBoardId = freezed,
    Object? cachedAt = null,
  }) {
    return _then(
      _value.copyWith(
            boards: null == boards
                ? _value.boards
                : boards // ignore: cast_nullable_to_non_nullable
                      as List<Board>,
            boardOrder: null == boardOrder
                ? _value.boardOrder
                : boardOrder // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            recentBoardIds: null == recentBoardIds
                ? _value.recentBoardIds
                : recentBoardIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            selectedBoardId: freezed == selectedBoardId
                ? _value.selectedBoardId
                : selectedBoardId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CollectionsCacheDataImplCopyWith<$Res>
    implements $CollectionsCacheDataCopyWith<$Res> {
  factory _$$CollectionsCacheDataImplCopyWith(
    _$CollectionsCacheDataImpl value,
    $Res Function(_$CollectionsCacheDataImpl) then,
  ) = __$$CollectionsCacheDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Board> boards,
    List<String> boardOrder,
    List<String> recentBoardIds,
    String? selectedBoardId,
    DateTime cachedAt,
  });
}

/// @nodoc
class __$$CollectionsCacheDataImplCopyWithImpl<$Res>
    extends _$CollectionsCacheDataCopyWithImpl<$Res, _$CollectionsCacheDataImpl>
    implements _$$CollectionsCacheDataImplCopyWith<$Res> {
  __$$CollectionsCacheDataImplCopyWithImpl(
    _$CollectionsCacheDataImpl _value,
    $Res Function(_$CollectionsCacheDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CollectionsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boards = null,
    Object? boardOrder = null,
    Object? recentBoardIds = null,
    Object? selectedBoardId = freezed,
    Object? cachedAt = null,
  }) {
    return _then(
      _$CollectionsCacheDataImpl(
        boards: null == boards
            ? _value._boards
            : boards // ignore: cast_nullable_to_non_nullable
                  as List<Board>,
        boardOrder: null == boardOrder
            ? _value._boardOrder
            : boardOrder // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        recentBoardIds: null == recentBoardIds
            ? _value._recentBoardIds
            : recentBoardIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        selectedBoardId: freezed == selectedBoardId
            ? _value.selectedBoardId
            : selectedBoardId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$CollectionsCacheDataImpl implements _CollectionsCacheData {
  const _$CollectionsCacheDataImpl({
    required final List<Board> boards,
    required final List<String> boardOrder,
    required final List<String> recentBoardIds,
    this.selectedBoardId,
    required this.cachedAt,
  }) : _boards = boards,
       _boardOrder = boardOrder,
       _recentBoardIds = recentBoardIds;

  factory _$CollectionsCacheDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionsCacheDataImplFromJson(json);

  final List<Board> _boards;
  @override
  List<Board> get boards {
    if (_boards is EqualUnmodifiableListView) return _boards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boards);
  }

  final List<String> _boardOrder;
  @override
  List<String> get boardOrder {
    if (_boardOrder is EqualUnmodifiableListView) return _boardOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boardOrder);
  }

  final List<String> _recentBoardIds;
  @override
  List<String> get recentBoardIds {
    if (_recentBoardIds is EqualUnmodifiableListView) return _recentBoardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentBoardIds);
  }

  @override
  final String? selectedBoardId;
  @override
  final DateTime cachedAt;

  @override
  String toString() {
    return 'CollectionsCacheData(boards: $boards, boardOrder: $boardOrder, recentBoardIds: $recentBoardIds, selectedBoardId: $selectedBoardId, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionsCacheDataImpl &&
            const DeepCollectionEquality().equals(other._boards, _boards) &&
            const DeepCollectionEquality().equals(
              other._boardOrder,
              _boardOrder,
            ) &&
            const DeepCollectionEquality().equals(
              other._recentBoardIds,
              _recentBoardIds,
            ) &&
            (identical(other.selectedBoardId, selectedBoardId) ||
                other.selectedBoardId == selectedBoardId) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_boards),
    const DeepCollectionEquality().hash(_boardOrder),
    const DeepCollectionEquality().hash(_recentBoardIds),
    selectedBoardId,
    cachedAt,
  );

  /// Create a copy of CollectionsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionsCacheDataImplCopyWith<_$CollectionsCacheDataImpl>
  get copyWith =>
      __$$CollectionsCacheDataImplCopyWithImpl<_$CollectionsCacheDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionsCacheDataImplToJson(this);
  }
}

abstract class _CollectionsCacheData implements CollectionsCacheData {
  const factory _CollectionsCacheData({
    required final List<Board> boards,
    required final List<String> boardOrder,
    required final List<String> recentBoardIds,
    final String? selectedBoardId,
    required final DateTime cachedAt,
  }) = _$CollectionsCacheDataImpl;

  factory _CollectionsCacheData.fromJson(Map<String, dynamic> json) =
      _$CollectionsCacheDataImpl.fromJson;

  @override
  List<Board> get boards;
  @override
  List<String> get boardOrder;
  @override
  List<String> get recentBoardIds;
  @override
  String? get selectedBoardId;
  @override
  DateTime get cachedAt;

  /// Create a copy of CollectionsCacheData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionsCacheDataImplCopyWith<_$CollectionsCacheDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}
