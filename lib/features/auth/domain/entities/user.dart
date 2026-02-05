// ignore_for_file: invalid_annotation_target

// User domain entity with Freezed
// Core user representation for business logic

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Represents an authenticated user in the app
///
/// This is a domain entity that abstracts away the Clerk user model.
/// The app should use this entity instead of directly depending on Clerk types.
@freezed
class User with _$User {
  const User._();

  const factory User({
    /// Unique user identifier from Clerk
    required String id,

    /// User's email address
    String? email,

    /// User's first name
    String? firstName,

    /// User's last name
    String? lastName,

    /// User's profile image URL
    String? imageUrl,

    /// User's username (if set)
    String? username,

    /// Whether the user's email is verified
    @Default(false) bool emailVerified,

    /// Timestamp of user creation
    DateTime? createdAt,

    /// Timestamp of last update
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Full display name (first + last name)
  String get fullName {
    final parts = <String>[];
    if (firstName != null && firstName!.isNotEmpty) parts.add(firstName!);
    if (lastName != null && lastName!.isNotEmpty) parts.add(lastName!);
    return parts.isEmpty ? 'User' : parts.join(' ');
  }

  /// Display name with fallback to email or username
  String get displayName {
    if (fullName != 'User') return fullName;
    if (username != null && username!.isNotEmpty) return username!;
    if (email != null && email!.isNotEmpty) return email!.split('@').first;
    return 'User';
  }

  /// First initial for avatar fallback
  String get initial {
    if (firstName != null && firstName!.isNotEmpty) {
      return firstName![0].toUpperCase();
    }
    if (email != null && email!.isNotEmpty) {
      return email![0].toUpperCase();
    }
    return 'U';
  }
}
