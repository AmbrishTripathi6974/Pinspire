// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingState {
  /// Whether onboarding has been completed
  bool get hasCompleted => throw _privateConstructorUsedError;

  /// Current step in the onboarding flow
  OnboardingStep get currentStep => throw _privateConstructorUsedError;

  /// Selected gender
  Gender? get selectedGender => throw _privateConstructorUsedError;

  /// Custom gender text (when other is selected)
  String? get customGender => throw _privateConstructorUsedError;

  /// Selected country code
  String? get selectedCountryCode => throw _privateConstructorUsedError;

  /// Selected interest IDs
  Set<String> get selectedInterests => throw _privateConstructorUsedError;

  /// Whether the state has been initialized from storage
  bool get isInitialized => throw _privateConstructorUsedError;

  /// Loading state
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
    OnboardingState value,
    $Res Function(OnboardingState) then,
  ) = _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call({
    bool hasCompleted,
    OnboardingStep currentStep,
    Gender? selectedGender,
    String? customGender,
    String? selectedCountryCode,
    Set<String> selectedInterests,
    bool isInitialized,
    bool isLoading,
  });
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasCompleted = null,
    Object? currentStep = null,
    Object? selectedGender = freezed,
    Object? customGender = freezed,
    Object? selectedCountryCode = freezed,
    Object? selectedInterests = null,
    Object? isInitialized = null,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            hasCompleted: null == hasCompleted
                ? _value.hasCompleted
                : hasCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as OnboardingStep,
            selectedGender: freezed == selectedGender
                ? _value.selectedGender
                : selectedGender // ignore: cast_nullable_to_non_nullable
                      as Gender?,
            customGender: freezed == customGender
                ? _value.customGender
                : customGender // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedCountryCode: freezed == selectedCountryCode
                ? _value.selectedCountryCode
                : selectedCountryCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedInterests: null == selectedInterests
                ? _value.selectedInterests
                : selectedInterests // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingStateImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$OnboardingStateImplCopyWith(
    _$OnboardingStateImpl value,
    $Res Function(_$OnboardingStateImpl) then,
  ) = __$$OnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool hasCompleted,
    OnboardingStep currentStep,
    Gender? selectedGender,
    String? customGender,
    String? selectedCountryCode,
    Set<String> selectedInterests,
    bool isInitialized,
    bool isLoading,
  });
}

/// @nodoc
class __$$OnboardingStateImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingStateImpl>
    implements _$$OnboardingStateImplCopyWith<$Res> {
  __$$OnboardingStateImplCopyWithImpl(
    _$OnboardingStateImpl _value,
    $Res Function(_$OnboardingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasCompleted = null,
    Object? currentStep = null,
    Object? selectedGender = freezed,
    Object? customGender = freezed,
    Object? selectedCountryCode = freezed,
    Object? selectedInterests = null,
    Object? isInitialized = null,
    Object? isLoading = null,
  }) {
    return _then(
      _$OnboardingStateImpl(
        hasCompleted: null == hasCompleted
            ? _value.hasCompleted
            : hasCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as OnboardingStep,
        selectedGender: freezed == selectedGender
            ? _value.selectedGender
            : selectedGender // ignore: cast_nullable_to_non_nullable
                  as Gender?,
        customGender: freezed == customGender
            ? _value.customGender
            : customGender // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedCountryCode: freezed == selectedCountryCode
            ? _value.selectedCountryCode
            : selectedCountryCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedInterests: null == selectedInterests
            ? _value._selectedInterests
            : selectedInterests // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$OnboardingStateImpl extends _OnboardingState {
  const _$OnboardingStateImpl({
    this.hasCompleted = false,
    this.currentStep = OnboardingStep.gender,
    this.selectedGender,
    this.customGender,
    this.selectedCountryCode,
    final Set<String> selectedInterests = const {},
    this.isInitialized = false,
    this.isLoading = false,
  }) : _selectedInterests = selectedInterests,
       super._();

  /// Whether onboarding has been completed
  @override
  @JsonKey()
  final bool hasCompleted;

  /// Current step in the onboarding flow
  @override
  @JsonKey()
  final OnboardingStep currentStep;

  /// Selected gender
  @override
  final Gender? selectedGender;

  /// Custom gender text (when other is selected)
  @override
  final String? customGender;

  /// Selected country code
  @override
  final String? selectedCountryCode;

  /// Selected interest IDs
  final Set<String> _selectedInterests;

  /// Selected interest IDs
  @override
  @JsonKey()
  Set<String> get selectedInterests {
    if (_selectedInterests is EqualUnmodifiableSetView)
      return _selectedInterests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedInterests);
  }

  /// Whether the state has been initialized from storage
  @override
  @JsonKey()
  final bool isInitialized;

  /// Loading state
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'OnboardingState(hasCompleted: $hasCompleted, currentStep: $currentStep, selectedGender: $selectedGender, customGender: $customGender, selectedCountryCode: $selectedCountryCode, selectedInterests: $selectedInterests, isInitialized: $isInitialized, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            (identical(other.hasCompleted, hasCompleted) ||
                other.hasCompleted == hasCompleted) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.selectedGender, selectedGender) ||
                other.selectedGender == selectedGender) &&
            (identical(other.customGender, customGender) ||
                other.customGender == customGender) &&
            (identical(other.selectedCountryCode, selectedCountryCode) ||
                other.selectedCountryCode == selectedCountryCode) &&
            const DeepCollectionEquality().equals(
              other._selectedInterests,
              _selectedInterests,
            ) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasCompleted,
    currentStep,
    selectedGender,
    customGender,
    selectedCountryCode,
    const DeepCollectionEquality().hash(_selectedInterests),
    isInitialized,
    isLoading,
  );

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      __$$OnboardingStateImplCopyWithImpl<_$OnboardingStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingState extends OnboardingState {
  const factory _OnboardingState({
    final bool hasCompleted,
    final OnboardingStep currentStep,
    final Gender? selectedGender,
    final String? customGender,
    final String? selectedCountryCode,
    final Set<String> selectedInterests,
    final bool isInitialized,
    final bool isLoading,
  }) = _$OnboardingStateImpl;
  const _OnboardingState._() : super._();

  /// Whether onboarding has been completed
  @override
  bool get hasCompleted;

  /// Current step in the onboarding flow
  @override
  OnboardingStep get currentStep;

  /// Selected gender
  @override
  Gender? get selectedGender;

  /// Custom gender text (when other is selected)
  @override
  String? get customGender;

  /// Selected country code
  @override
  String? get selectedCountryCode;

  /// Selected interest IDs
  @override
  Set<String> get selectedInterests;

  /// Whether the state has been initialized from storage
  @override
  bool get isInitialized;

  /// Loading state
  @override
  bool get isLoading;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
