// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthUiState _$AuthUiStateFromJson(Map<String, dynamic> json) {
  return _AuthUiState.fromJson(json);
}

/// @nodoc
mixin _$AuthUiState {
  /// Whether user has completed onboarding
  bool get hasSeenOnboarding => throw _privateConstructorUsedError;

  /// Last viewed auth screen (for resuming flow)
  AuthScreen get lastAuthScreen => throw _privateConstructorUsedError;

  /// Whether to remember email for login
  bool get rememberEmail => throw _privateConstructorUsedError;

  /// Saved email for auto-fill
  String? get savedEmail => throw _privateConstructorUsedError;

  /// Whether auth form is currently submitting
  bool get isSubmitting => throw _privateConstructorUsedError;

  /// Validation errors by field
  Map<String, String> get fieldErrors => throw _privateConstructorUsedError;

  /// General error message
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this AuthUiState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUiStateCopyWith<AuthUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUiStateCopyWith<$Res> {
  factory $AuthUiStateCopyWith(
    AuthUiState value,
    $Res Function(AuthUiState) then,
  ) = _$AuthUiStateCopyWithImpl<$Res, AuthUiState>;
  @useResult
  $Res call({
    bool hasSeenOnboarding,
    AuthScreen lastAuthScreen,
    bool rememberEmail,
    String? savedEmail,
    bool isSubmitting,
    Map<String, String> fieldErrors,
    String? error,
  });
}

/// @nodoc
class _$AuthUiStateCopyWithImpl<$Res, $Val extends AuthUiState>
    implements $AuthUiStateCopyWith<$Res> {
  _$AuthUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasSeenOnboarding = null,
    Object? lastAuthScreen = null,
    Object? rememberEmail = null,
    Object? savedEmail = freezed,
    Object? isSubmitting = null,
    Object? fieldErrors = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            hasSeenOnboarding: null == hasSeenOnboarding
                ? _value.hasSeenOnboarding
                : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastAuthScreen: null == lastAuthScreen
                ? _value.lastAuthScreen
                : lastAuthScreen // ignore: cast_nullable_to_non_nullable
                      as AuthScreen,
            rememberEmail: null == rememberEmail
                ? _value.rememberEmail
                : rememberEmail // ignore: cast_nullable_to_non_nullable
                      as bool,
            savedEmail: freezed == savedEmail
                ? _value.savedEmail
                : savedEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            fieldErrors: null == fieldErrors
                ? _value.fieldErrors
                : fieldErrors // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthUiStateImplCopyWith<$Res>
    implements $AuthUiStateCopyWith<$Res> {
  factory _$$AuthUiStateImplCopyWith(
    _$AuthUiStateImpl value,
    $Res Function(_$AuthUiStateImpl) then,
  ) = __$$AuthUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool hasSeenOnboarding,
    AuthScreen lastAuthScreen,
    bool rememberEmail,
    String? savedEmail,
    bool isSubmitting,
    Map<String, String> fieldErrors,
    String? error,
  });
}

/// @nodoc
class __$$AuthUiStateImplCopyWithImpl<$Res>
    extends _$AuthUiStateCopyWithImpl<$Res, _$AuthUiStateImpl>
    implements _$$AuthUiStateImplCopyWith<$Res> {
  __$$AuthUiStateImplCopyWithImpl(
    _$AuthUiStateImpl _value,
    $Res Function(_$AuthUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasSeenOnboarding = null,
    Object? lastAuthScreen = null,
    Object? rememberEmail = null,
    Object? savedEmail = freezed,
    Object? isSubmitting = null,
    Object? fieldErrors = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AuthUiStateImpl(
        hasSeenOnboarding: null == hasSeenOnboarding
            ? _value.hasSeenOnboarding
            : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastAuthScreen: null == lastAuthScreen
            ? _value.lastAuthScreen
            : lastAuthScreen // ignore: cast_nullable_to_non_nullable
                  as AuthScreen,
        rememberEmail: null == rememberEmail
            ? _value.rememberEmail
            : rememberEmail // ignore: cast_nullable_to_non_nullable
                  as bool,
        savedEmail: freezed == savedEmail
            ? _value.savedEmail
            : savedEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        fieldErrors: null == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUiStateImpl extends _AuthUiState {
  const _$AuthUiStateImpl({
    this.hasSeenOnboarding = false,
    this.lastAuthScreen = AuthScreen.login,
    this.rememberEmail = false,
    this.savedEmail,
    this.isSubmitting = false,
    final Map<String, String> fieldErrors = const {},
    this.error,
  }) : _fieldErrors = fieldErrors,
       super._();

  factory _$AuthUiStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUiStateImplFromJson(json);

  /// Whether user has completed onboarding
  @override
  @JsonKey()
  final bool hasSeenOnboarding;

  /// Last viewed auth screen (for resuming flow)
  @override
  @JsonKey()
  final AuthScreen lastAuthScreen;

  /// Whether to remember email for login
  @override
  @JsonKey()
  final bool rememberEmail;

  /// Saved email for auto-fill
  @override
  final String? savedEmail;

  /// Whether auth form is currently submitting
  @override
  @JsonKey()
  final bool isSubmitting;

  /// Validation errors by field
  final Map<String, String> _fieldErrors;

  /// Validation errors by field
  @override
  @JsonKey()
  Map<String, String> get fieldErrors {
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldErrors);
  }

  /// General error message
  @override
  final String? error;

  @override
  String toString() {
    return 'AuthUiState(hasSeenOnboarding: $hasSeenOnboarding, lastAuthScreen: $lastAuthScreen, rememberEmail: $rememberEmail, savedEmail: $savedEmail, isSubmitting: $isSubmitting, fieldErrors: $fieldErrors, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUiStateImpl &&
            (identical(other.hasSeenOnboarding, hasSeenOnboarding) ||
                other.hasSeenOnboarding == hasSeenOnboarding) &&
            (identical(other.lastAuthScreen, lastAuthScreen) ||
                other.lastAuthScreen == lastAuthScreen) &&
            (identical(other.rememberEmail, rememberEmail) ||
                other.rememberEmail == rememberEmail) &&
            (identical(other.savedEmail, savedEmail) ||
                other.savedEmail == savedEmail) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasSeenOnboarding,
    lastAuthScreen,
    rememberEmail,
    savedEmail,
    isSubmitting,
    const DeepCollectionEquality().hash(_fieldErrors),
    error,
  );

  /// Create a copy of AuthUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUiStateImplCopyWith<_$AuthUiStateImpl> get copyWith =>
      __$$AuthUiStateImplCopyWithImpl<_$AuthUiStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUiStateImplToJson(this);
  }
}

abstract class _AuthUiState extends AuthUiState {
  const factory _AuthUiState({
    final bool hasSeenOnboarding,
    final AuthScreen lastAuthScreen,
    final bool rememberEmail,
    final String? savedEmail,
    final bool isSubmitting,
    final Map<String, String> fieldErrors,
    final String? error,
  }) = _$AuthUiStateImpl;
  const _AuthUiState._() : super._();

  factory _AuthUiState.fromJson(Map<String, dynamic> json) =
      _$AuthUiStateImpl.fromJson;

  /// Whether user has completed onboarding
  @override
  bool get hasSeenOnboarding;

  /// Last viewed auth screen (for resuming flow)
  @override
  AuthScreen get lastAuthScreen;

  /// Whether to remember email for login
  @override
  bool get rememberEmail;

  /// Saved email for auto-fill
  @override
  String? get savedEmail;

  /// Whether auth form is currently submitting
  @override
  bool get isSubmitting;

  /// Validation errors by field
  @override
  Map<String, String> get fieldErrors;

  /// General error message
  @override
  String? get error;

  /// Create a copy of AuthUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUiStateImplCopyWith<_$AuthUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
