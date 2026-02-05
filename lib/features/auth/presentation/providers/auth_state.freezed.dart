// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthError error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthError error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthError error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthStateInitialImplCopyWith<$Res> {
  factory _$$AuthStateInitialImplCopyWith(
    _$AuthStateInitialImpl value,
    $Res Function(_$AuthStateInitialImpl) then,
  ) = __$$AuthStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateInitialImpl>
    implements _$$AuthStateInitialImplCopyWith<$Res> {
  __$$AuthStateInitialImplCopyWithImpl(
    _$AuthStateInitialImpl _value,
    $Res Function(_$AuthStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateInitialImpl implements AuthStateInitial {
  const _$AuthStateInitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthError error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthError error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthError error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthStateInitial implements AuthState {
  const factory AuthStateInitial() = _$AuthStateInitialImpl;
}

/// @nodoc
abstract class _$$AuthStateLoadingImplCopyWith<$Res> {
  factory _$$AuthStateLoadingImplCopyWith(
    _$AuthStateLoadingImpl value,
    $Res Function(_$AuthStateLoadingImpl) then,
  ) = __$$AuthStateLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AuthStateLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateLoadingImpl>
    implements _$$AuthStateLoadingImplCopyWith<$Res> {
  __$$AuthStateLoadingImplCopyWithImpl(
    _$AuthStateLoadingImpl _value,
    $Res Function(_$AuthStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$AuthStateLoadingImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateLoadingImpl implements AuthStateLoading {
  const _$AuthStateLoadingImpl({this.message});

  /// Optional message describing the operation
  @override
  final String? message;

  @override
  String toString() {
    return 'AuthState.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateLoadingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateLoadingImplCopyWith<_$AuthStateLoadingImpl> get copyWith =>
      __$$AuthStateLoadingImplCopyWithImpl<_$AuthStateLoadingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthError error) error,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthError error)? error,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthError error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthStateLoading implements AuthState {
  const factory AuthStateLoading({final String? message}) =
      _$AuthStateLoadingImpl;

  /// Optional message describing the operation
  String? get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateLoadingImplCopyWith<_$AuthStateLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateAuthenticatedImplCopyWith(
    _$AuthStateAuthenticatedImpl value,
    $Res Function(_$AuthStateAuthenticatedImpl) then,
  ) = __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateAuthenticatedImpl>
    implements _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  __$$AuthStateAuthenticatedImplCopyWithImpl(
    _$AuthStateAuthenticatedImpl _value,
    $Res Function(_$AuthStateAuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null}) {
    return _then(
      _$AuthStateAuthenticatedImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthStateAuthenticatedImpl implements AuthStateAuthenticated {
  const _$AuthStateAuthenticatedImpl({required this.user});

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateAuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
  get copyWith =>
      __$$AuthStateAuthenticatedImplCopyWithImpl<_$AuthStateAuthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthError error) error,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthError error)? error,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthError error)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateAuthenticated implements AuthState {
  const factory AuthStateAuthenticated({required final User user}) =
      _$AuthStateAuthenticatedImpl;

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateUnauthenticatedImplCopyWith(
    _$AuthStateUnauthenticatedImpl value,
    $Res Function(_$AuthStateUnauthenticatedImpl) then,
  ) = __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateUnauthenticatedImpl>
    implements _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  __$$AuthStateUnauthenticatedImplCopyWithImpl(
    _$AuthStateUnauthenticatedImpl _value,
    $Res Function(_$AuthStateUnauthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateUnauthenticatedImpl implements AuthStateUnauthenticated {
  const _$AuthStateUnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateUnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthError error) error,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthError error)? error,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthError error)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateUnauthenticated implements AuthState {
  const factory AuthStateUnauthenticated() = _$AuthStateUnauthenticatedImpl;
}

/// @nodoc
abstract class _$$AuthStateErrorImplCopyWith<$Res> {
  factory _$$AuthStateErrorImplCopyWith(
    _$AuthStateErrorImpl value,
    $Res Function(_$AuthStateErrorImpl) then,
  ) = __$$AuthStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthError error});

  $AuthErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$AuthStateErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateErrorImpl>
    implements _$$AuthStateErrorImplCopyWith<$Res> {
  __$$AuthStateErrorImplCopyWithImpl(
    _$AuthStateErrorImpl _value,
    $Res Function(_$AuthStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$AuthStateErrorImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as AuthError,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthErrorCopyWith<$Res> get error {
    return $AuthErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$AuthStateErrorImpl implements AuthStateError {
  const _$AuthStateErrorImpl({required this.error});

  @override
  final AuthError error;

  @override
  String toString() {
    return 'AuthState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateErrorImplCopyWith<_$AuthStateErrorImpl> get copyWith =>
      __$$AuthStateErrorImplCopyWithImpl<_$AuthStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AuthError error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthError error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AuthError error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthStateError implements AuthState {
  const factory AuthStateError({required final AuthError error}) =
      _$AuthStateErrorImpl;

  AuthError get error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateErrorImplCopyWith<_$AuthStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthError {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthErrorCopyWith<AuthError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthErrorCopyWith<$Res> {
  factory $AuthErrorCopyWith(AuthError value, $Res Function(AuthError) then) =
      _$AuthErrorCopyWithImpl<$Res, AuthError>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AuthErrorCopyWithImpl<$Res, $Val extends AuthError>
    implements $AuthErrorCopyWith<$Res> {
  _$AuthErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthErrorInvalidCredentialsImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorInvalidCredentialsImplCopyWith(
    _$AuthErrorInvalidCredentialsImpl value,
    $Res Function(_$AuthErrorInvalidCredentialsImpl) then,
  ) = __$$AuthErrorInvalidCredentialsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorInvalidCredentialsImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorInvalidCredentialsImpl>
    implements _$$AuthErrorInvalidCredentialsImplCopyWith<$Res> {
  __$$AuthErrorInvalidCredentialsImplCopyWithImpl(
    _$AuthErrorInvalidCredentialsImpl _value,
    $Res Function(_$AuthErrorInvalidCredentialsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorInvalidCredentialsImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorInvalidCredentialsImpl implements AuthErrorInvalidCredentials {
  const _$AuthErrorInvalidCredentialsImpl({
    this.message = 'Invalid email or password',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.invalidCredentials(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorInvalidCredentialsImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorInvalidCredentialsImplCopyWith<_$AuthErrorInvalidCredentialsImpl>
  get copyWith =>
      __$$AuthErrorInvalidCredentialsImplCopyWithImpl<
        _$AuthErrorInvalidCredentialsImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return invalidCredentials(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return invalidCredentials?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (invalidCredentials != null) {
      return invalidCredentials(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return invalidCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return invalidCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidCredentials != null) {
      return invalidCredentials(this);
    }
    return orElse();
  }
}

abstract class AuthErrorInvalidCredentials implements AuthError {
  const factory AuthErrorInvalidCredentials({final String message}) =
      _$AuthErrorInvalidCredentialsImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorInvalidCredentialsImplCopyWith<_$AuthErrorInvalidCredentialsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorUserNotFoundImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorUserNotFoundImplCopyWith(
    _$AuthErrorUserNotFoundImpl value,
    $Res Function(_$AuthErrorUserNotFoundImpl) then,
  ) = __$$AuthErrorUserNotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorUserNotFoundImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorUserNotFoundImpl>
    implements _$$AuthErrorUserNotFoundImplCopyWith<$Res> {
  __$$AuthErrorUserNotFoundImplCopyWithImpl(
    _$AuthErrorUserNotFoundImpl _value,
    $Res Function(_$AuthErrorUserNotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorUserNotFoundImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorUserNotFoundImpl implements AuthErrorUserNotFound {
  const _$AuthErrorUserNotFoundImpl({
    this.message = 'No account found with this email',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.userNotFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorUserNotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorUserNotFoundImplCopyWith<_$AuthErrorUserNotFoundImpl>
  get copyWith =>
      __$$AuthErrorUserNotFoundImplCopyWithImpl<_$AuthErrorUserNotFoundImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return userNotFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return userNotFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (userNotFound != null) {
      return userNotFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return userNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return userNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (userNotFound != null) {
      return userNotFound(this);
    }
    return orElse();
  }
}

abstract class AuthErrorUserNotFound implements AuthError {
  const factory AuthErrorUserNotFound({final String message}) =
      _$AuthErrorUserNotFoundImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorUserNotFoundImplCopyWith<_$AuthErrorUserNotFoundImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorEmailAlreadyInUseImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorEmailAlreadyInUseImplCopyWith(
    _$AuthErrorEmailAlreadyInUseImpl value,
    $Res Function(_$AuthErrorEmailAlreadyInUseImpl) then,
  ) = __$$AuthErrorEmailAlreadyInUseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorEmailAlreadyInUseImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorEmailAlreadyInUseImpl>
    implements _$$AuthErrorEmailAlreadyInUseImplCopyWith<$Res> {
  __$$AuthErrorEmailAlreadyInUseImplCopyWithImpl(
    _$AuthErrorEmailAlreadyInUseImpl _value,
    $Res Function(_$AuthErrorEmailAlreadyInUseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorEmailAlreadyInUseImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorEmailAlreadyInUseImpl implements AuthErrorEmailAlreadyInUse {
  const _$AuthErrorEmailAlreadyInUseImpl({
    this.message = 'An account already exists with this email',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.emailAlreadyInUse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorEmailAlreadyInUseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorEmailAlreadyInUseImplCopyWith<_$AuthErrorEmailAlreadyInUseImpl>
  get copyWith =>
      __$$AuthErrorEmailAlreadyInUseImplCopyWithImpl<
        _$AuthErrorEmailAlreadyInUseImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return emailAlreadyInUse(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return emailAlreadyInUse?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (emailAlreadyInUse != null) {
      return emailAlreadyInUse(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return emailAlreadyInUse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return emailAlreadyInUse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (emailAlreadyInUse != null) {
      return emailAlreadyInUse(this);
    }
    return orElse();
  }
}

abstract class AuthErrorEmailAlreadyInUse implements AuthError {
  const factory AuthErrorEmailAlreadyInUse({final String message}) =
      _$AuthErrorEmailAlreadyInUseImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorEmailAlreadyInUseImplCopyWith<_$AuthErrorEmailAlreadyInUseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorWeakPasswordImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorWeakPasswordImplCopyWith(
    _$AuthErrorWeakPasswordImpl value,
    $Res Function(_$AuthErrorWeakPasswordImpl) then,
  ) = __$$AuthErrorWeakPasswordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorWeakPasswordImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorWeakPasswordImpl>
    implements _$$AuthErrorWeakPasswordImplCopyWith<$Res> {
  __$$AuthErrorWeakPasswordImplCopyWithImpl(
    _$AuthErrorWeakPasswordImpl _value,
    $Res Function(_$AuthErrorWeakPasswordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorWeakPasswordImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorWeakPasswordImpl implements AuthErrorWeakPassword {
  const _$AuthErrorWeakPasswordImpl({this.message = 'Password is too weak'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.weakPassword(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorWeakPasswordImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorWeakPasswordImplCopyWith<_$AuthErrorWeakPasswordImpl>
  get copyWith =>
      __$$AuthErrorWeakPasswordImplCopyWithImpl<_$AuthErrorWeakPasswordImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return weakPassword(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return weakPassword?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (weakPassword != null) {
      return weakPassword(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return weakPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return weakPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (weakPassword != null) {
      return weakPassword(this);
    }
    return orElse();
  }
}

abstract class AuthErrorWeakPassword implements AuthError {
  const factory AuthErrorWeakPassword({final String message}) =
      _$AuthErrorWeakPasswordImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorWeakPasswordImplCopyWith<_$AuthErrorWeakPasswordImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorEmailNotVerifiedImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorEmailNotVerifiedImplCopyWith(
    _$AuthErrorEmailNotVerifiedImpl value,
    $Res Function(_$AuthErrorEmailNotVerifiedImpl) then,
  ) = __$$AuthErrorEmailNotVerifiedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorEmailNotVerifiedImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorEmailNotVerifiedImpl>
    implements _$$AuthErrorEmailNotVerifiedImplCopyWith<$Res> {
  __$$AuthErrorEmailNotVerifiedImplCopyWithImpl(
    _$AuthErrorEmailNotVerifiedImpl _value,
    $Res Function(_$AuthErrorEmailNotVerifiedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorEmailNotVerifiedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorEmailNotVerifiedImpl implements AuthErrorEmailNotVerified {
  const _$AuthErrorEmailNotVerifiedImpl({
    this.message = 'Please verify your email address',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.emailNotVerified(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorEmailNotVerifiedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorEmailNotVerifiedImplCopyWith<_$AuthErrorEmailNotVerifiedImpl>
  get copyWith =>
      __$$AuthErrorEmailNotVerifiedImplCopyWithImpl<
        _$AuthErrorEmailNotVerifiedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return emailNotVerified(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return emailNotVerified?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (emailNotVerified != null) {
      return emailNotVerified(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return emailNotVerified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return emailNotVerified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (emailNotVerified != null) {
      return emailNotVerified(this);
    }
    return orElse();
  }
}

abstract class AuthErrorEmailNotVerified implements AuthError {
  const factory AuthErrorEmailNotVerified({final String message}) =
      _$AuthErrorEmailNotVerifiedImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorEmailNotVerifiedImplCopyWith<_$AuthErrorEmailNotVerifiedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorSessionExpiredImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorSessionExpiredImplCopyWith(
    _$AuthErrorSessionExpiredImpl value,
    $Res Function(_$AuthErrorSessionExpiredImpl) then,
  ) = __$$AuthErrorSessionExpiredImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorSessionExpiredImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorSessionExpiredImpl>
    implements _$$AuthErrorSessionExpiredImplCopyWith<$Res> {
  __$$AuthErrorSessionExpiredImplCopyWithImpl(
    _$AuthErrorSessionExpiredImpl _value,
    $Res Function(_$AuthErrorSessionExpiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorSessionExpiredImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorSessionExpiredImpl implements AuthErrorSessionExpired {
  const _$AuthErrorSessionExpiredImpl({
    this.message = 'Your session has expired. Please sign in again.',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.sessionExpired(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorSessionExpiredImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorSessionExpiredImplCopyWith<_$AuthErrorSessionExpiredImpl>
  get copyWith =>
      __$$AuthErrorSessionExpiredImplCopyWithImpl<
        _$AuthErrorSessionExpiredImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return sessionExpired(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return sessionExpired?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (sessionExpired != null) {
      return sessionExpired(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return sessionExpired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return sessionExpired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (sessionExpired != null) {
      return sessionExpired(this);
    }
    return orElse();
  }
}

abstract class AuthErrorSessionExpired implements AuthError {
  const factory AuthErrorSessionExpired({final String message}) =
      _$AuthErrorSessionExpiredImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorSessionExpiredImplCopyWith<_$AuthErrorSessionExpiredImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorNetworkImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorNetworkImplCopyWith(
    _$AuthErrorNetworkImpl value,
    $Res Function(_$AuthErrorNetworkImpl) then,
  ) = __$$AuthErrorNetworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorNetworkImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorNetworkImpl>
    implements _$$AuthErrorNetworkImplCopyWith<$Res> {
  __$$AuthErrorNetworkImplCopyWithImpl(
    _$AuthErrorNetworkImpl _value,
    $Res Function(_$AuthErrorNetworkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorNetworkImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorNetworkImpl implements AuthErrorNetwork {
  const _$AuthErrorNetworkImpl({
    this.message = 'Network error. Please check your connection.',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorNetworkImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorNetworkImplCopyWith<_$AuthErrorNetworkImpl> get copyWith =>
      __$$AuthErrorNetworkImplCopyWithImpl<_$AuthErrorNetworkImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class AuthErrorNetwork implements AuthError {
  const factory AuthErrorNetwork({final String message}) =
      _$AuthErrorNetworkImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorNetworkImplCopyWith<_$AuthErrorNetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorTooManyRequestsImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorTooManyRequestsImplCopyWith(
    _$AuthErrorTooManyRequestsImpl value,
    $Res Function(_$AuthErrorTooManyRequestsImpl) then,
  ) = __$$AuthErrorTooManyRequestsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorTooManyRequestsImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorTooManyRequestsImpl>
    implements _$$AuthErrorTooManyRequestsImplCopyWith<$Res> {
  __$$AuthErrorTooManyRequestsImplCopyWithImpl(
    _$AuthErrorTooManyRequestsImpl _value,
    $Res Function(_$AuthErrorTooManyRequestsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorTooManyRequestsImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorTooManyRequestsImpl implements AuthErrorTooManyRequests {
  const _$AuthErrorTooManyRequestsImpl({
    this.message = 'Too many attempts. Please try again later.',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.tooManyRequests(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorTooManyRequestsImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorTooManyRequestsImplCopyWith<_$AuthErrorTooManyRequestsImpl>
  get copyWith =>
      __$$AuthErrorTooManyRequestsImplCopyWithImpl<
        _$AuthErrorTooManyRequestsImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return tooManyRequests(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return tooManyRequests?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (tooManyRequests != null) {
      return tooManyRequests(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return tooManyRequests(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return tooManyRequests?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (tooManyRequests != null) {
      return tooManyRequests(this);
    }
    return orElse();
  }
}

abstract class AuthErrorTooManyRequests implements AuthError {
  const factory AuthErrorTooManyRequests({final String message}) =
      _$AuthErrorTooManyRequestsImpl;

  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorTooManyRequestsImplCopyWith<_$AuthErrorTooManyRequestsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorOAuthFailedImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorOAuthFailedImplCopyWith(
    _$AuthErrorOAuthFailedImpl value,
    $Res Function(_$AuthErrorOAuthFailedImpl) then,
  ) = __$$AuthErrorOAuthFailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String provider, String message});
}

/// @nodoc
class __$$AuthErrorOAuthFailedImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorOAuthFailedImpl>
    implements _$$AuthErrorOAuthFailedImplCopyWith<$Res> {
  __$$AuthErrorOAuthFailedImplCopyWithImpl(
    _$AuthErrorOAuthFailedImpl _value,
    $Res Function(_$AuthErrorOAuthFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? provider = null, Object? message = null}) {
    return _then(
      _$AuthErrorOAuthFailedImpl(
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorOAuthFailedImpl implements AuthErrorOAuthFailed {
  const _$AuthErrorOAuthFailedImpl({
    required this.provider,
    this.message = 'Authentication failed',
  });

  @override
  final String provider;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthError.oauthFailed(provider: $provider, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorOAuthFailedImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider, message);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorOAuthFailedImplCopyWith<_$AuthErrorOAuthFailedImpl>
  get copyWith =>
      __$$AuthErrorOAuthFailedImplCopyWithImpl<_$AuthErrorOAuthFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return oauthFailed(provider, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return oauthFailed?.call(provider, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (oauthFailed != null) {
      return oauthFailed(provider, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return oauthFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return oauthFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (oauthFailed != null) {
      return oauthFailed(this);
    }
    return orElse();
  }
}

abstract class AuthErrorOAuthFailed implements AuthError {
  const factory AuthErrorOAuthFailed({
    required final String provider,
    final String message,
  }) = _$AuthErrorOAuthFailedImpl;

  String get provider;
  @override
  String get message;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorOAuthFailedImplCopyWith<_$AuthErrorOAuthFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorUnknownImplCopyWith<$Res>
    implements $AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorUnknownImplCopyWith(
    _$AuthErrorUnknownImpl value,
    $Res Function(_$AuthErrorUnknownImpl) then,
  ) = __$$AuthErrorUnknownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? originalError});
}

/// @nodoc
class __$$AuthErrorUnknownImplCopyWithImpl<$Res>
    extends _$AuthErrorCopyWithImpl<$Res, _$AuthErrorUnknownImpl>
    implements _$$AuthErrorUnknownImplCopyWith<$Res> {
  __$$AuthErrorUnknownImplCopyWithImpl(
    _$AuthErrorUnknownImpl _value,
    $Res Function(_$AuthErrorUnknownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? originalError = freezed}) {
    return _then(
      _$AuthErrorUnknownImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        originalError: freezed == originalError
            ? _value.originalError
            : originalError,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorUnknownImpl implements AuthErrorUnknown {
  const _$AuthErrorUnknownImpl({
    this.message = 'An unexpected error occurred',
    this.originalError,
  });

  @override
  @JsonKey()
  final String message;
  @override
  final Object? originalError;

  @override
  String toString() {
    return 'AuthError.unknown(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorUnknownImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other.originalError,
              originalError,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(originalError),
  );

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorUnknownImplCopyWith<_$AuthErrorUnknownImpl> get copyWith =>
      __$$AuthErrorUnknownImplCopyWithImpl<_$AuthErrorUnknownImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidCredentials,
    required TResult Function(String message) userNotFound,
    required TResult Function(String message) emailAlreadyInUse,
    required TResult Function(String message) weakPassword,
    required TResult Function(String message) emailNotVerified,
    required TResult Function(String message) sessionExpired,
    required TResult Function(String message) network,
    required TResult Function(String message) tooManyRequests,
    required TResult Function(String provider, String message) oauthFailed,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return unknown(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidCredentials,
    TResult? Function(String message)? userNotFound,
    TResult? Function(String message)? emailAlreadyInUse,
    TResult? Function(String message)? weakPassword,
    TResult? Function(String message)? emailNotVerified,
    TResult? Function(String message)? sessionExpired,
    TResult? Function(String message)? network,
    TResult? Function(String message)? tooManyRequests,
    TResult? Function(String provider, String message)? oauthFailed,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return unknown?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidCredentials,
    TResult Function(String message)? userNotFound,
    TResult Function(String message)? emailAlreadyInUse,
    TResult Function(String message)? weakPassword,
    TResult Function(String message)? emailNotVerified,
    TResult Function(String message)? sessionExpired,
    TResult Function(String message)? network,
    TResult Function(String message)? tooManyRequests,
    TResult Function(String provider, String message)? oauthFailed,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthErrorInvalidCredentials value)
    invalidCredentials,
    required TResult Function(AuthErrorUserNotFound value) userNotFound,
    required TResult Function(AuthErrorEmailAlreadyInUse value)
    emailAlreadyInUse,
    required TResult Function(AuthErrorWeakPassword value) weakPassword,
    required TResult Function(AuthErrorEmailNotVerified value) emailNotVerified,
    required TResult Function(AuthErrorSessionExpired value) sessionExpired,
    required TResult Function(AuthErrorNetwork value) network,
    required TResult Function(AuthErrorTooManyRequests value) tooManyRequests,
    required TResult Function(AuthErrorOAuthFailed value) oauthFailed,
    required TResult Function(AuthErrorUnknown value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult? Function(AuthErrorUserNotFound value)? userNotFound,
    TResult? Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(AuthErrorWeakPassword value)? weakPassword,
    TResult? Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult? Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult? Function(AuthErrorNetwork value)? network,
    TResult? Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult? Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult? Function(AuthErrorUnknown value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthErrorInvalidCredentials value)? invalidCredentials,
    TResult Function(AuthErrorUserNotFound value)? userNotFound,
    TResult Function(AuthErrorEmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(AuthErrorWeakPassword value)? weakPassword,
    TResult Function(AuthErrorEmailNotVerified value)? emailNotVerified,
    TResult Function(AuthErrorSessionExpired value)? sessionExpired,
    TResult Function(AuthErrorNetwork value)? network,
    TResult Function(AuthErrorTooManyRequests value)? tooManyRequests,
    TResult Function(AuthErrorOAuthFailed value)? oauthFailed,
    TResult Function(AuthErrorUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class AuthErrorUnknown implements AuthError {
  const factory AuthErrorUnknown({
    final String message,
    final Object? originalError,
  }) = _$AuthErrorUnknownImpl;

  @override
  String get message;
  Object? get originalError;

  /// Create a copy of AuthError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorUnknownImplCopyWith<_$AuthErrorUnknownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
