// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_ui_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUiStateImpl _$$AuthUiStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthUiStateImpl(
      hasSeenOnboarding: json['hasSeenOnboarding'] as bool? ?? false,
      lastAuthScreen:
          $enumDecodeNullable(_$AuthScreenEnumMap, json['lastAuthScreen']) ??
          AuthScreen.login,
      rememberEmail: json['rememberEmail'] as bool? ?? false,
      savedEmail: json['savedEmail'] as String?,
      isSubmitting: json['isSubmitting'] as bool? ?? false,
      fieldErrors:
          (json['fieldErrors'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$AuthUiStateImplToJson(_$AuthUiStateImpl instance) =>
    <String, dynamic>{
      'hasSeenOnboarding': instance.hasSeenOnboarding,
      'lastAuthScreen': _$AuthScreenEnumMap[instance.lastAuthScreen]!,
      'rememberEmail': instance.rememberEmail,
      'savedEmail': instance.savedEmail,
      'isSubmitting': instance.isSubmitting,
      'fieldErrors': instance.fieldErrors,
      'error': instance.error,
    };

const _$AuthScreenEnumMap = {
  AuthScreen.login: 'login',
  AuthScreen.register: 'register',
  AuthScreen.forgotPassword: 'forgotPassword',
  AuthScreen.verification: 'verification',
};
