// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InboxState {
  Set<String> get readUpdateIds => throw _privateConstructorUsedError;
  Set<String> get hiddenUpdateIds => throw _privateConstructorUsedError;

  /// Create a copy of InboxState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxStateCopyWith<InboxState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxStateCopyWith<$Res> {
  factory $InboxStateCopyWith(
    InboxState value,
    $Res Function(InboxState) then,
  ) = _$InboxStateCopyWithImpl<$Res, InboxState>;
  @useResult
  $Res call({Set<String> readUpdateIds, Set<String> hiddenUpdateIds});
}

/// @nodoc
class _$InboxStateCopyWithImpl<$Res, $Val extends InboxState>
    implements $InboxStateCopyWith<$Res> {
  _$InboxStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? readUpdateIds = null, Object? hiddenUpdateIds = null}) {
    return _then(
      _value.copyWith(
            readUpdateIds: null == readUpdateIds
                ? _value.readUpdateIds
                : readUpdateIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            hiddenUpdateIds: null == hiddenUpdateIds
                ? _value.hiddenUpdateIds
                : hiddenUpdateIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InboxStateImplCopyWith<$Res>
    implements $InboxStateCopyWith<$Res> {
  factory _$$InboxStateImplCopyWith(
    _$InboxStateImpl value,
    $Res Function(_$InboxStateImpl) then,
  ) = __$$InboxStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<String> readUpdateIds, Set<String> hiddenUpdateIds});
}

/// @nodoc
class __$$InboxStateImplCopyWithImpl<$Res>
    extends _$InboxStateCopyWithImpl<$Res, _$InboxStateImpl>
    implements _$$InboxStateImplCopyWith<$Res> {
  __$$InboxStateImplCopyWithImpl(
    _$InboxStateImpl _value,
    $Res Function(_$InboxStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InboxState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? readUpdateIds = null, Object? hiddenUpdateIds = null}) {
    return _then(
      _$InboxStateImpl(
        readUpdateIds: null == readUpdateIds
            ? _value._readUpdateIds
            : readUpdateIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        hiddenUpdateIds: null == hiddenUpdateIds
            ? _value._hiddenUpdateIds
            : hiddenUpdateIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc

class _$InboxStateImpl implements _InboxState {
  const _$InboxStateImpl({
    final Set<String> readUpdateIds = const {},
    final Set<String> hiddenUpdateIds = const {},
  }) : _readUpdateIds = readUpdateIds,
       _hiddenUpdateIds = hiddenUpdateIds;

  final Set<String> _readUpdateIds;
  @override
  @JsonKey()
  Set<String> get readUpdateIds {
    if (_readUpdateIds is EqualUnmodifiableSetView) return _readUpdateIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_readUpdateIds);
  }

  final Set<String> _hiddenUpdateIds;
  @override
  @JsonKey()
  Set<String> get hiddenUpdateIds {
    if (_hiddenUpdateIds is EqualUnmodifiableSetView) return _hiddenUpdateIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_hiddenUpdateIds);
  }

  @override
  String toString() {
    return 'InboxState(readUpdateIds: $readUpdateIds, hiddenUpdateIds: $hiddenUpdateIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxStateImpl &&
            const DeepCollectionEquality().equals(
              other._readUpdateIds,
              _readUpdateIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._hiddenUpdateIds,
              _hiddenUpdateIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_readUpdateIds),
    const DeepCollectionEquality().hash(_hiddenUpdateIds),
  );

  /// Create a copy of InboxState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxStateImplCopyWith<_$InboxStateImpl> get copyWith =>
      __$$InboxStateImplCopyWithImpl<_$InboxStateImpl>(this, _$identity);
}

abstract class _InboxState implements InboxState {
  const factory _InboxState({
    final Set<String> readUpdateIds,
    final Set<String> hiddenUpdateIds,
  }) = _$InboxStateImpl;

  @override
  Set<String> get readUpdateIds;
  @override
  Set<String> get hiddenUpdateIds;

  /// Create a copy of InboxState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxStateImplCopyWith<_$InboxStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
