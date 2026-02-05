// auth_state.dart
// Authentication state with Freezed
// Defines auth states: initial, loading, authenticated, unauthenticated, error

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinterest/features/auth/domain/entities/user.dart';

part 'auth_state.freezed.dart';

/// Authentication state for the application
///
/// Represents all possible states in the authentication flow:
/// - [initial]: App just started, auth state unknown
/// - [loading]: Auth operation in progress
/// - [authenticated]: User is signed in
/// - [unauthenticated]: User is signed out
/// - [error]: An auth error occurred
@freezed
sealed class AuthState with _$AuthState {
  /// Initial state - auth status unknown
  const factory AuthState.initial() = AuthStateInitial;

  /// Loading state - auth operation in progress
  const factory AuthState.loading({
    /// Optional message describing the operation
    String? message,
  }) = AuthStateLoading;

  /// Authenticated state - user is signed in
  const factory AuthState.authenticated({
    required User user,
  }) = AuthStateAuthenticated;

  /// Unauthenticated state - user is signed out
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;

  /// Error state - an auth error occurred
  const factory AuthState.error({
    required AuthError error,
  }) = AuthStateError;
}

/// Authentication error types
@freezed
sealed class AuthError with _$AuthError {
  /// Invalid credentials (wrong email/password)
  const factory AuthError.invalidCredentials({
    @Default('Invalid email or password') String message,
  }) = AuthErrorInvalidCredentials;

  /// User not found
  const factory AuthError.userNotFound({
    @Default('No account found with this email') String message,
  }) = AuthErrorUserNotFound;

  /// Email already in use (during registration)
  const factory AuthError.emailAlreadyInUse({
    @Default('An account already exists with this email') String message,
  }) = AuthErrorEmailAlreadyInUse;

  /// Weak password (during registration)
  const factory AuthError.weakPassword({
    @Default('Password is too weak') String message,
  }) = AuthErrorWeakPassword;

  /// Email not verified
  const factory AuthError.emailNotVerified({
    @Default('Please verify your email address') String message,
  }) = AuthErrorEmailNotVerified;

  /// Session expired
  const factory AuthError.sessionExpired({
    @Default('Your session has expired. Please sign in again.') String message,
  }) = AuthErrorSessionExpired;

  /// Network error
  const factory AuthError.network({
    @Default('Network error. Please check your connection.') String message,
  }) = AuthErrorNetwork;

  /// Too many requests (rate limited)
  const factory AuthError.tooManyRequests({
    @Default('Too many attempts. Please try again later.') String message,
  }) = AuthErrorTooManyRequests;

  /// OAuth error (Google, Apple, etc.)
  const factory AuthError.oauthFailed({
    required String provider,
    @Default('Authentication failed') String message,
  }) = AuthErrorOAuthFailed;

  /// Generic/unknown error
  const factory AuthError.unknown({
    @Default('An unexpected error occurred') String message,
    Object? originalError,
  }) = AuthErrorUnknown;
}

/// Extension methods for AuthState
extension AuthStateX on AuthState {
  /// Whether the user is authenticated
  bool get isAuthenticated => this is AuthStateAuthenticated;

  /// Whether auth is loading
  bool get isLoading => this is AuthStateLoading;

  /// Whether there's an error
  bool get hasError => this is AuthStateError;

  /// Get the user if authenticated, null otherwise
  User? get user => switch (this) {
        AuthStateAuthenticated(:final user) => user,
        _ => null,
      };

  /// Get the error if in error state, null otherwise
  AuthError? get error => switch (this) {
        AuthStateError(:final error) => error,
        _ => null,
      };
}

/// Extension methods for AuthError
extension AuthErrorX on AuthError {
  /// Get user-friendly error message
  String get displayMessage => switch (this) {
        AuthErrorInvalidCredentials(:final message) => message,
        AuthErrorUserNotFound(:final message) => message,
        AuthErrorEmailAlreadyInUse(:final message) => message,
        AuthErrorWeakPassword(:final message) => message,
        AuthErrorEmailNotVerified(:final message) => message,
        AuthErrorSessionExpired(:final message) => message,
        AuthErrorNetwork(:final message) => message,
        AuthErrorTooManyRequests(:final message) => message,
        AuthErrorOAuthFailed(:final message) => message,
        AuthErrorUnknown(:final message) => message,
      };

  /// Whether the error requires user to re-authenticate
  bool get requiresReauth => switch (this) {
        AuthErrorSessionExpired() => true,
        AuthErrorInvalidCredentials() => true,
        _ => false,
      };
}
