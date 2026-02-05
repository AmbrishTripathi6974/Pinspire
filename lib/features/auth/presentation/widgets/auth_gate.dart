// AuthGate widget for handling authentication-based navigation
// Decides which screen to show based on Clerk auth state
// No business logic - just reactive navigation based on auth state

import 'dart:async';

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/core/router/app_router.dart';
import 'package:pinterest/features/auth/data/services/clerk_auth_service.dart';
import 'package:pinterest/features/auth/presentation/providers/auth_provider.dart';
import 'package:pinterest/features/auth/presentation/widgets/clerk_auth_scope.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

/// AuthGate widget that controls navigation based on authentication state
///
/// This widget:
/// - Listens to Clerk auth state changes
/// - Shows auth screen when signed out
/// - Shows main app when signed in
/// - Provides smooth transitions between states
/// - Does NOT push screens on top - replaces the entire screen
///
/// Usage:
/// ```dart
/// AuthGate(
///   authenticatedBuilder: (context) => MainAppShell(),
///   unauthenticatedBuilder: (context) => AuthScreen(),
/// )
/// ```
class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({
    super.key,
    required this.authenticatedBuilder,
    required this.unauthenticatedBuilder,
    this.loadingBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.onAuthStateResolved,
  });

  /// Builder for the authenticated (signed-in) state
  final WidgetBuilder authenticatedBuilder;

  /// Builder for the unauthenticated (signed-out) state
  final WidgetBuilder unauthenticatedBuilder;

  /// Optional builder for loading state
  /// If null, shows Pinterest-style centered dots loader
  final WidgetBuilder? loadingBuilder;

  /// Duration for the fade transition between states
  final Duration transitionDuration;

  /// Callback invoked when auth state is resolved (either signed in or signed out)
  /// Useful for removing native splash screen or other initialization tasks
  final VoidCallback? onAuthStateResolved;

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool _wasSignedIn = false;
  bool _authStateResolved = false;
  bool _isInitialCheck = true;
  Timer? _showLoginTimer;

  @override
  void dispose() {
    _showLoginTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check local storage flag - if user is logged in, skip delay but still use ClerkAuthBuilder
    // This allows Clerk to sync user data while preventing login screen flash
    final isLoggedInFlag = ref.read(isLoggedInFlagProvider);
    final localStorage = ref.read(localStorageProvider);
    
    return ClerkAuthBuilder(
      signedInBuilder: (context, authState) {
        // Cancel any pending login screen display
        _showLoginTimer?.cancel();
        _showLoginTimer = null;
        
        // Update logged in flag in local storage
        localStorage.setBool(StorageKeys.isLoggedIn, true);
        
        // Sync after frame so we don't modify provider during build.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            // Get previous user ID before syncing
            final previousUser = ref.read(authStateProvider);
            final previousUserId = previousUser?.id;
            
            // Check if this is a fresh login (transition from unauthenticated) 
            // vs session restoration (user was already authenticated)
            final isFreshLogin = previousUser == null && !_wasSignedIn;
            
            // Sync auth state to get new user ID
            _syncAuthState(authState);
            
            // Check if user changed (different user logged in)
            final newUser = ref.read(authStateProvider);
            final newUserId = newUser?.id;
            final userChanged = previousUserId != null && 
                               newUserId != null && 
                               previousUserId != newUserId;
            
            // If user changed, invalidate all user-scoped providers to load new user's data
            if (userChanged) {
              ref.invalidate(savedPinsProvider);
              ref.invalidate(collectionsProvider);
              ref.invalidate(feedProvider);
              ref.invalidate(onboardingProvider);
              ref.invalidate(navigationProvider);
            }
            
            // Only mark as "just logged in" for actual login transitions,
            // not when Clerk restores an existing session
            if (isFreshLogin) {
              _wasSignedIn = true;
              ref.read(justLoggedInProvider.notifier).state = true;
            } else if (newUser != null) {
              // Existing session restored - update flag but don't set justLoggedIn
              _wasSignedIn = true;
            }
            
            // Mark initial check as complete
            _isInitialCheck = false;
            
            // Notify that auth state is resolved (for removing native splash, etc.)
            if (!_authStateResolved) {
              _authStateResolved = true;
              widget.onAuthStateResolved?.call();
            }
          }
        });
        return _AnimatedAuthTransition(
          key: const ValueKey('authenticated'),
          duration: widget.transitionDuration,
          child: ClerkAuthScope(
            authState: authState,
            child: widget.authenticatedBuilder(context),
          ),
        );
      },
      signedOutBuilder: (context, authState) {
        // During initial check, delay showing login screen to allow Clerk
        // time to check for existing session. This prevents flashing login screen
        // when user is already logged in but Clerk hasn't restored session yet.
        // However, if flag says user is logged in, skip delay and show loading
        // (Clerk will likely find the session and switch to signedInBuilder)
        if (_isInitialCheck) {
          // If flag says user is logged in, show loading screen (not login)
          // Clerk will verify session and switch to signedInBuilder if valid
          if (isLoggedInFlag) {
            // Show loading screen - Clerk will verify session
            return _AnimatedAuthTransition(
              key: const ValueKey('auth_loading'),
              duration: widget.transitionDuration,
              child: widget.loadingBuilder?.call(context) ??
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Scaffold(
                      body: PinterestDotsLoader.centered(),
                    ),
                  ),
            );
          }
          
          // Cancel any existing timer
          _showLoginTimer?.cancel();
          
          // Set a timer to show login screen after a short delay
          // If user is authenticated, signedInBuilder will be called and cancel this timer
          _showLoginTimer = Timer(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _isInitialCheck = false;
                // Mark auth state as resolved since we've waited long enough
                if (!_authStateResolved) {
                  _authStateResolved = true;
                  widget.onAuthStateResolved?.call();
                }
              });
            }
          });
          
          // Show loading screen during initial check
          // Use loadingBuilder if provided (wraps in MaterialApp), otherwise use fallback
          return _AnimatedAuthTransition(
            key: const ValueKey('auth_loading'),
            duration: widget.transitionDuration,
            child: widget.loadingBuilder?.call(context) ??
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    body: PinterestDotsLoader.centered(),
                  ),
                ),
          );
        }
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _wasSignedIn = false;
            _clearAuthState();
            
            // Update logged out flag in local storage
            localStorage.setBool(StorageKeys.isLoggedIn, false);
            
            // Notify that auth state is resolved (for removing native splash, etc.)
            if (!_authStateResolved) {
              _authStateResolved = true;
              widget.onAuthStateResolved?.call();
            }
          }
        });
        
        return _AnimatedAuthTransition(
          key: const ValueKey('unauthenticated'),
          duration: widget.transitionDuration,
          child: widget.unauthenticatedBuilder(context),
        );
      },
      // When Clerk hasn't resolved yet (e.g. initial load), show loading indicator
      builder: (context, _) => _AnimatedAuthTransition(
        key: const ValueKey('auth_loading'),
        duration: widget.transitionDuration,
        child: widget.loadingBuilder?.call(context) ??
            Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                body: PinterestDotsLoader.centered(),
              ),
            ),
      ),
    );
  }

  /// Syncs Clerk auth state to Riverpod. Called after build (via Future.microtask)
  /// so we don't modify provider during build. GoRouter's refreshListenable
  /// then re-runs redirect and sends authenticated user to home.
  void _syncAuthState(ClerkAuthState authState) {
    final user = authState.toDomainUser();
    ref.read(authStateProvider.notifier).setUser(user);
  }

  /// Clears auth state in Riverpod when signed out.
  /// Also clears user-specific data from storage.
  void _clearAuthState() {
    ref.read(authStateProvider.notifier).clearUser();
    
    // Clear user-specific data when logging out
    // This ensures next user sees fresh data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Invalidate all user-scoped providers to force reload with new user context
        ref.invalidate(savedPinsProvider);
        ref.invalidate(collectionsProvider);
        ref.invalidate(feedProvider);
        ref.invalidate(onboardingProvider);
        ref.invalidate(navigationProvider);
      }
    });
  }
}

/// Animated transition wrapper for auth state changes
///
/// Provides a smooth fade transition when switching between
/// authenticated and unauthenticated states.
class _AnimatedAuthTransition extends StatelessWidget {
  const _AnimatedAuthTransition({
    super.key,
    required this.child,
    required this.duration,
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
