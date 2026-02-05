// Riverpod providers for authentication state
// Manages auth state and exposes auth actions
//
// Note: Clerk manages session state internally via ClerkAuth widget.
// These providers bridge Clerk state to Riverpod for app-wide access.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/auth/data/services/clerk_auth_service.dart';
import 'package:pinterest/features/auth/domain/entities/user.dart';

// =============================================================================
// Auth Service Provider
// =============================================================================

/// Provider for the ClerkAuthService
///
/// This is a stateless service for mapping Clerk types
final clerkAuthServiceProvider = Provider<ClerkAuthService>((ref) {
  return const ClerkAuthService();
});

// =============================================================================
// Auth State Notifier
// =============================================================================

/// Holds the current authenticated user state
///
/// This is updated by the ClerkAuthBuilder in the widget tree
/// when Clerk's session state changes.
class AuthStateNotifier extends StateNotifier<User?> {
  AuthStateNotifier() : super(null);

  /// Updates the current user
  void setUser(User? user) {
    state = user;
  }

  /// Clears the current user (on sign out)
  void clearUser() {
    state = null;
  }
}

/// Provider for the current authenticated user
///
/// Updated by ClerkAuthBuilder when session changes
final authStateProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  return AuthStateNotifier();
});

// =============================================================================
// Convenience Providers
// =============================================================================

/// Whether the user is currently authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider) != null;
});

/// Set to true when user transitions from signed out to signed in (login/re-login).
/// Used by router redirect to send user to home instead of previous route.
/// Cleared after redirect runs.
final justLoggedInProvider = StateProvider<bool>((ref) => false);

/// Current user's display name
final currentUserNameProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider)?.displayName;
});

/// Current user's email
final currentUserEmailProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider)?.email;
});

/// Current user's avatar URL
final currentUserAvatarProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider)?.imageUrl;
});

/// Current user's ID
final currentUserIdProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider)?.id;
});
