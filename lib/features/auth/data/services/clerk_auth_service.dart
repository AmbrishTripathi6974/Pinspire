// Clerk authentication service wrapper
// Provides a clean interface for Clerk authentication operations
// Isolates Clerk SDK dependency from the rest of the app

import 'package:clerk_auth/clerk_auth.dart' show User;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:pinterest/features/auth/domain/entities/user.dart' as domain;

/// Service that wraps Clerk authentication operations
///
/// This service:
/// - Provides a stateless interface to Clerk authentication
/// - Maps Clerk user models to domain User entities
/// - Handles authentication errors
///
/// Note: ClerkAuth widget handles session state internally.
/// This service is for imperative auth operations only.
class ClerkAuthService {
  const ClerkAuthService();

  /// Maps a Clerk user to our domain User entity
  ///
  /// Returns null if the Clerk user is null
  domain.User? mapClerkUser(User? clerkUser) {
    if (clerkUser == null) return null;

    // Extract primary email from email addresses list (nullable)
    final emailAddresses = clerkUser.emailAddresses;
    final primaryEmail =
        (emailAddresses != null && emailAddresses.isNotEmpty)
            ? emailAddresses.first
            : null;

    return domain.User(
      id: clerkUser.id,
      email: primaryEmail?.emailAddress,
      firstName: clerkUser.firstName,
      lastName: clerkUser.lastName,
      imageUrl: clerkUser.imageUrl,
      username: clerkUser.username,
      emailVerified: primaryEmail?.verification?.status.isVerified ?? false,
      createdAt: clerkUser.createdAt,
      updatedAt: clerkUser.updatedAt,
    );
  }

  /// Gets the current user from a ClerkAuthState
  domain.User? getCurrentUser(ClerkAuthState authState) {
    return mapClerkUser(authState.user);
  }

  /// Checks if user is authenticated from auth state
  bool isAuthenticated(ClerkAuthState authState) {
    return authState.user != null;
  }
}

/// Extension to easily convert ClerkAuthState to domain user
extension ClerkAuthStateExtension on ClerkAuthState {
  /// Converts Clerk user to domain User entity
  domain.User? toDomainUser() {
    const service = ClerkAuthService();
    return service.getCurrentUser(this);
  }

  /// Whether the user is currently signed in
  bool get isSignedIn => user != null;

  /// Whether the user is signed out
  bool get isSignedOut => user == null;
}
