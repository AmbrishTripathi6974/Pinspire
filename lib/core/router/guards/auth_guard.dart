// Route guard for protected routes
// Redirects unauthenticated users to login page

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/features/auth/presentation/providers/auth_provider.dart';

/// Redirect function for authentication.
///
/// This router is only used inside [AuthGate] when the user is signed in
/// (authenticated app). Redirects authenticated users away from auth routes.
///
/// IMPORTANT: This function is called during widget build phase, so we cannot
/// modify providers directly here. Provider modifications are deferred using
/// [SchedulerBinding.addPostFrameCallback] to avoid "modifying provider during build" errors.
String? authRedirect(Ref ref, GoRouterState state) {
  final isAuthenticated = ref.read(isAuthenticatedProvider);
  if (!isAuthenticated) return null;

  final location = state.matchedLocation;
  final isAuthRoute = location.startsWith('/auth');

  // Redirect authenticated users away from auth routes (e.g., leftover from deep link)
  if (isAuthRoute) {
    // Clear justLoggedIn flag if it was set (shouldn't happen for session restoration)
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(justLoggedInProvider.notifier).state = false;
    });
    return AppRoutes.home;
  }

  // Handle fresh login: redirect to home unless user is already on a valid shell tab
  // Note: justLoggedIn is only set for actual login transitions, not session restoration
  final justLoggedIn = ref.read(justLoggedInProvider);
  if (justLoggedIn) {
    // Clear the flag after redirect
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(justLoggedInProvider.notifier).state = false;
    });
    
    // Allow navigation to shell tabs (user's intended destination)
    final isShellTab = location == AppRoutes.home ||
        location == AppRoutes.search ||
        location == AppRoutes.create ||
        location == AppRoutes.notifications ||
        location == AppRoutes.profile;
    if (isShellTab) return null;
    
    // Redirect to home for any other route after login
    return AppRoutes.home;
  }
  
  return null;
}

/// Routes that require authentication
const List<String> protectedRoutes = [
  AppRoutes.profile,
  AppRoutes.create,
  AppRoutes.notifications,
  AppRoutes.savedPath,
  AppRoutes.boardsPath,
  AppRoutes.settingsPath,
  AppRoutes.editProfilePath,
  AppRoutes.createBoard,
];

/// Routes that should be accessible without authentication
const List<String> publicRoutes = [
  AppRoutes.home,
  AppRoutes.search,
  AppRoutes.login,
  AppRoutes.signUp,
  AppRoutes.forgotPassword,
  AppRoutes.onboarding,
];

/// Checks if a route requires authentication
bool isProtectedRoute(String location) {
  return protectedRoutes.any((route) => location.startsWith(route));
}

/// Checks if a route is public
bool isPublicRoute(String location) {
  return publicRoutes.any((route) => location.startsWith(route));
}
