// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NavigationState _$NavigationStateFromJson(Map<String, dynamic> json) {
  return _NavigationState.fromJson(json);
}

/// @nodoc
mixin _$NavigationState {
  /// Currently selected tab
  AppTab get selectedTab => throw _privateConstructorUsedError;

  /// Previous tab for back navigation
  AppTab? get previousTab => throw _privateConstructorUsedError;

  /// Whether bottom nav is visible
  bool get isBottomNavVisible => throw _privateConstructorUsedError;

  /// Whether navigation state has been initialized
  bool get isInitialized => throw _privateConstructorUsedError;

  /// Current deep link path (if navigated via deep link)
  String? get deepLinkPath => throw _privateConstructorUsedError;

  /// Serializes this NavigationState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavigationStateCopyWith<NavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStateCopyWith<$Res> {
  factory $NavigationStateCopyWith(
    NavigationState value,
    $Res Function(NavigationState) then,
  ) = _$NavigationStateCopyWithImpl<$Res, NavigationState>;
  @useResult
  $Res call({
    AppTab selectedTab,
    AppTab? previousTab,
    bool isBottomNavVisible,
    bool isInitialized,
    String? deepLinkPath,
  });
}

/// @nodoc
class _$NavigationStateCopyWithImpl<$Res, $Val extends NavigationState>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTab = null,
    Object? previousTab = freezed,
    Object? isBottomNavVisible = null,
    Object? isInitialized = null,
    Object? deepLinkPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedTab: null == selectedTab
                ? _value.selectedTab
                : selectedTab // ignore: cast_nullable_to_non_nullable
                      as AppTab,
            previousTab: freezed == previousTab
                ? _value.previousTab
                : previousTab // ignore: cast_nullable_to_non_nullable
                      as AppTab?,
            isBottomNavVisible: null == isBottomNavVisible
                ? _value.isBottomNavVisible
                : isBottomNavVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            deepLinkPath: freezed == deepLinkPath
                ? _value.deepLinkPath
                : deepLinkPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NavigationStateImplCopyWith<$Res>
    implements $NavigationStateCopyWith<$Res> {
  factory _$$NavigationStateImplCopyWith(
    _$NavigationStateImpl value,
    $Res Function(_$NavigationStateImpl) then,
  ) = __$$NavigationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AppTab selectedTab,
    AppTab? previousTab,
    bool isBottomNavVisible,
    bool isInitialized,
    String? deepLinkPath,
  });
}

/// @nodoc
class __$$NavigationStateImplCopyWithImpl<$Res>
    extends _$NavigationStateCopyWithImpl<$Res, _$NavigationStateImpl>
    implements _$$NavigationStateImplCopyWith<$Res> {
  __$$NavigationStateImplCopyWithImpl(
    _$NavigationStateImpl _value,
    $Res Function(_$NavigationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTab = null,
    Object? previousTab = freezed,
    Object? isBottomNavVisible = null,
    Object? isInitialized = null,
    Object? deepLinkPath = freezed,
  }) {
    return _then(
      _$NavigationStateImpl(
        selectedTab: null == selectedTab
            ? _value.selectedTab
            : selectedTab // ignore: cast_nullable_to_non_nullable
                  as AppTab,
        previousTab: freezed == previousTab
            ? _value.previousTab
            : previousTab // ignore: cast_nullable_to_non_nullable
                  as AppTab?,
        isBottomNavVisible: null == isBottomNavVisible
            ? _value.isBottomNavVisible
            : isBottomNavVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        deepLinkPath: freezed == deepLinkPath
            ? _value.deepLinkPath
            : deepLinkPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NavigationStateImpl extends _NavigationState {
  const _$NavigationStateImpl({
    this.selectedTab = AppTab.home,
    this.previousTab,
    this.isBottomNavVisible = true,
    this.isInitialized = false,
    this.deepLinkPath,
  }) : super._();

  factory _$NavigationStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavigationStateImplFromJson(json);

  /// Currently selected tab
  @override
  @JsonKey()
  final AppTab selectedTab;

  /// Previous tab for back navigation
  @override
  final AppTab? previousTab;

  /// Whether bottom nav is visible
  @override
  @JsonKey()
  final bool isBottomNavVisible;

  /// Whether navigation state has been initialized
  @override
  @JsonKey()
  final bool isInitialized;

  /// Current deep link path (if navigated via deep link)
  @override
  final String? deepLinkPath;

  @override
  String toString() {
    return 'NavigationState(selectedTab: $selectedTab, previousTab: $previousTab, isBottomNavVisible: $isBottomNavVisible, isInitialized: $isInitialized, deepLinkPath: $deepLinkPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigationStateImpl &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.previousTab, previousTab) ||
                other.previousTab == previousTab) &&
            (identical(other.isBottomNavVisible, isBottomNavVisible) ||
                other.isBottomNavVisible == isBottomNavVisible) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.deepLinkPath, deepLinkPath) ||
                other.deepLinkPath == deepLinkPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedTab,
    previousTab,
    isBottomNavVisible,
    isInitialized,
    deepLinkPath,
  );

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigationStateImplCopyWith<_$NavigationStateImpl> get copyWith =>
      __$$NavigationStateImplCopyWithImpl<_$NavigationStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NavigationStateImplToJson(this);
  }
}

abstract class _NavigationState extends NavigationState {
  const factory _NavigationState({
    final AppTab selectedTab,
    final AppTab? previousTab,
    final bool isBottomNavVisible,
    final bool isInitialized,
    final String? deepLinkPath,
  }) = _$NavigationStateImpl;
  const _NavigationState._() : super._();

  factory _NavigationState.fromJson(Map<String, dynamic> json) =
      _$NavigationStateImpl.fromJson;

  /// Currently selected tab
  @override
  AppTab get selectedTab;

  /// Previous tab for back navigation
  @override
  AppTab? get previousTab;

  /// Whether bottom nav is visible
  @override
  bool get isBottomNavVisible;

  /// Whether navigation state has been initialized
  @override
  bool get isInitialized;

  /// Current deep link path (if navigated via deep link)
  @override
  String? get deepLinkPath;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigationStateImplCopyWith<_$NavigationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
