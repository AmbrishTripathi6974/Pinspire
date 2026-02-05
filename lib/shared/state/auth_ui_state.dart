// Auth UI state with Freezed
// Immutable state for auth-related UI (not session management)

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_ui_state.freezed.dart';
part 'auth_ui_state.g.dart';

/// Last viewed auth screen
enum AuthScreen {
  login,
  register,
  forgotPassword,
  verification,
}

/// Immutable state for auth UI
///
/// Note: This handles UI state only, not authentication session.
/// Clerk handles actual authentication.
@freezed
class AuthUiState with _$AuthUiState {
  const AuthUiState._();

  const factory AuthUiState({
    /// Whether user has completed onboarding
    @Default(false) bool hasSeenOnboarding,

    /// Last viewed auth screen (for resuming flow)
    @Default(AuthScreen.login) AuthScreen lastAuthScreen,

    /// Whether to remember email for login
    @Default(false) bool rememberEmail,

    /// Saved email for auto-fill
    String? savedEmail,

    /// Whether auth form is currently submitting
    @Default(false) bool isSubmitting,

    /// Validation errors by field
    @Default({}) Map<String, String> fieldErrors,

    /// General error message
    String? error,
  }) = _AuthUiState;

  factory AuthUiState.fromJson(Map<String, dynamic> json) =>
      _$AuthUiStateFromJson(json);

  /// Whether there are any field errors
  bool get hasFieldErrors => fieldErrors.isNotEmpty;

  /// Whether there's a general error
  bool get hasError => error != null && error!.isNotEmpty;

  /// Get error for specific field
  String? getFieldError(String field) => fieldErrors[field];

  /// Whether user should see onboarding
  bool get shouldShowOnboarding => !hasSeenOnboarding;
}
