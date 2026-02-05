/// Custom exception classes
/// Application-specific exceptions for different error scenarios
library;

/// Base exception for all application exceptions
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.cause,
  });

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

/// Exception thrown when cache operations fail
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.cause,
  });
}

/// Exception thrown when local storage operations fail
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.cause,
  });
}

/// Exception thrown when required data is not found
class DataNotFoundException extends AppException {
  const DataNotFoundException({
    required super.message,
    super.cause,
  });
}

/// Exception thrown when configuration is invalid or missing
class ConfigurationException extends AppException {
  const ConfigurationException({
    required super.message,
    super.cause,
  });
}

/// Exception thrown when authentication fails
/// Covers: invalid credentials, expired tokens, unauthorized access
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.cause,
    this.statusCode,
    this.isTokenExpired = false,
    this.isInvalidCredentials = false,
  });

  /// HTTP status code if available (401, 403, etc.)
  final int? statusCode;

  /// Whether the error is due to an expired token
  final bool isTokenExpired;

  /// Whether the error is due to invalid credentials
  final bool isInvalidCredentials;

  /// Factory for invalid API key errors
  factory AuthException.invalidApiKey({Object? cause}) {
    return AuthException(
      message: 'Invalid API key. Please check your configuration.',
      cause: cause,
      statusCode: 401,
      isInvalidCredentials: true,
    );
  }

  /// Factory for expired token errors
  factory AuthException.tokenExpired({Object? cause}) {
    return AuthException(
      message: 'Your session has expired. Please sign in again.',
      cause: cause,
      statusCode: 401,
      isTokenExpired: true,
    );
  }

  /// Factory for unauthorized access errors
  factory AuthException.unauthorized({String? message, Object? cause}) {
    return AuthException(
      message: message ?? 'You are not authorized to access this resource.',
      cause: cause,
      statusCode: 401,
    );
  }

  /// Factory for forbidden access errors
  factory AuthException.forbidden({String? message, Object? cause}) {
    return AuthException(
      message: message ?? 'Access denied. You do not have permission.',
      cause: cause,
      statusCode: 403,
    );
  }
}

/// Exception thrown when user session is invalid or not found
class SessionException extends AppException {
  const SessionException({
    required super.message,
    super.cause,
  });

  /// Factory for no active session
  factory SessionException.noSession() {
    return const SessionException(
      message: 'No active session. Please sign in.',
    );
  }

  /// Factory for session expired
  factory SessionException.expired() {
    return const SessionException(
      message: 'Your session has expired. Please sign in again.',
    );
  }
}
