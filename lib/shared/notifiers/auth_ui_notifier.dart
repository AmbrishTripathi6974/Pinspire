// Auth UI StateNotifier with SharedPreferences persistence
// Manages auth-related UI state (not session management)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/shared/state/auth_ui_state.dart';

/// StateNotifier for auth UI state
///
/// Handles UI state for authentication screens:
/// - Onboarding completion
/// - Remember email preference
/// - Form validation state
///
/// Note: Does NOT handle actual authentication session.
/// Clerk manages authentication.
class AuthUiNotifier extends StateNotifier<AuthUiState> {
  AuthUiNotifier({
    required LocalStorageService localStorage,
  })  : _localStorage = localStorage,
        super(const AuthUiState()) {
    _loadPersistedState();
  }

  final LocalStorageService _localStorage;

  /// Loads persisted state from SharedPreferences
  Future<void> _loadPersistedState() async {
    try {
      final hasSeenOnboarding =
          _localStorage.getBool(StorageKeys.hasSeenOnboarding) ?? false;

      final lastAuthScreenIndex =
          _localStorage.getInt(StorageKeys.lastAuthScreen) ?? 0;
      final lastAuthScreen = lastAuthScreenIndex < AuthScreen.values.length
          ? AuthScreen.values[lastAuthScreenIndex]
          : AuthScreen.login;

      final rememberEmail =
          _localStorage.getBool(StorageKeys.rememberEmail) ?? false;

      final savedEmail = rememberEmail
          ? _localStorage.getString(StorageKeys.savedEmail)
          : null;

      state = state.copyWith(
        hasSeenOnboarding: hasSeenOnboarding,
        lastAuthScreen: lastAuthScreen,
        rememberEmail: rememberEmail,
        savedEmail: savedEmail,
      );
    } catch (_) {
      // Use default state on error
    }
  }

  /// Persists current state to SharedPreferences
  Future<void> _persistState() async {
    try {
      await _localStorage.setBool(
        StorageKeys.hasSeenOnboarding,
        state.hasSeenOnboarding,
      );
      await _localStorage.setInt(
        StorageKeys.lastAuthScreen,
        state.lastAuthScreen.index,
      );
      await _localStorage.setBool(
        StorageKeys.rememberEmail,
        state.rememberEmail,
      );

      if (state.rememberEmail && state.savedEmail != null) {
        await _localStorage.setString(
          StorageKeys.savedEmail,
          state.savedEmail!,
        );
      } else {
        await _localStorage.remove(StorageKeys.savedEmail);
      }
    } catch (_) {
      // Silently fail
    }
  }

  /// Marks onboarding as completed
  Future<void> completeOnboarding() async {
    state = state.copyWith(hasSeenOnboarding: true);
    await _persistState();
  }

  /// Resets onboarding (for testing/debugging)
  Future<void> resetOnboarding() async {
    state = state.copyWith(hasSeenOnboarding: false);
    await _persistState();
  }

  /// Sets the current auth screen
  Future<void> setAuthScreen(AuthScreen screen) async {
    state = state.copyWith(lastAuthScreen: screen);
    await _persistState();
  }

  /// Toggles remember email preference
  Future<void> toggleRememberEmail() async {
    state = state.copyWith(rememberEmail: !state.rememberEmail);
    await _persistState();
  }

  /// Sets remember email preference
  Future<void> setRememberEmail(bool remember) async {
    state = state.copyWith(rememberEmail: remember);
    await _persistState();
  }

  /// Saves email for auto-fill
  Future<void> saveEmail(String email) async {
    state = state.copyWith(savedEmail: email);

    if (state.rememberEmail) {
      await _persistState();
    }
  }

  /// Clears saved email
  Future<void> clearSavedEmail() async {
    state = state.copyWith(savedEmail: null);
    await _persistState();
  }

  /// Sets submitting state
  void setSubmitting(bool isSubmitting) {
    state = state.copyWith(isSubmitting: isSubmitting);
  }

  /// Sets a field error
  void setFieldError(String field, String error) {
    final newErrors = Map<String, String>.from(state.fieldErrors);
    newErrors[field] = error;
    state = state.copyWith(fieldErrors: newErrors);
  }

  /// Clears a field error
  void clearFieldError(String field) {
    final newErrors = Map<String, String>.from(state.fieldErrors);
    newErrors.remove(field);
    state = state.copyWith(fieldErrors: newErrors);
  }

  /// Clears all field errors
  void clearAllFieldErrors() {
    state = state.copyWith(fieldErrors: {});
  }

  /// Sets a general error
  void setError(String error) {
    state = state.copyWith(error: error);
  }

  /// Clears the general error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Clears all errors and resets form state
  void resetFormState() {
    state = state.copyWith(
      isSubmitting: false,
      fieldErrors: {},
      error: null,
    );
  }
}
