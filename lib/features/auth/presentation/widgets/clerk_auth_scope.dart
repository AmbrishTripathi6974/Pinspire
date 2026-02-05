// clerk_auth_scope.dart
// Exposes ClerkAuthState to descendants so they can call signOut() programmatically

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

/// InheritedWidget that provides [ClerkAuthState] to the widget tree.
///
/// Used when signed in so that descendants (e.g. AccountPage) can call
/// [ClerkAuthState.signOut] for programmatic logout.
class ClerkAuthScope extends InheritedWidget {
  const ClerkAuthScope({
    super.key,
    required this.authState,
    required super.child,
  });

  final ClerkAuthState authState;

  /// Returns the [ClerkAuthScope] from the context, or null if not found.
  static ClerkAuthScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClerkAuthScope>();
  }

  /// Returns the [ClerkAuthScope] from the context.
  ///
  /// Throws if no [ClerkAuthScope] is found in the ancestor chain.
  static ClerkAuthScope of(BuildContext context) {
    final scope = maybeOf(context);
    assert(scope != null, 'No ClerkAuthScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(ClerkAuthScope oldWidget) {
    return authState != oldWidget.authState;
  }
}
