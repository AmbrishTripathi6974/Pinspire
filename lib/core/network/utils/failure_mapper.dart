/// Failure mapper utility
/// Maps API exceptions to domain-level Failure types
///
/// Provides a centralized, reusable mapping between network/API exceptions
/// and domain failures for use across services and repositories.

import 'package:pinterest/core/error/exceptions.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/core/network/exceptions/api_exception.dart';

/// Utility class for mapping exceptions to domain failures
///
/// This provides a single source of truth for exception-to-failure mapping,
/// ensuring consistent error handling across the data layer.
///
/// Example usage:
/// ```dart
/// try {
///   final result = await apiCall();
///   return Right(result);
/// } on ApiException catch (e) {
///   return Left(FailureMapper.fromApiException(e));
/// } catch (e) {
///   return Left(FailureMapper.fromException(e));
/// }
/// ```
abstract class FailureMapper {
  /// Maps an [ApiException] to a domain [Failure]
  ///
  /// Provides specific failure types based on the exception type:
  /// - [NetworkException] → [NetworkFailure]
  /// - [UnauthorizedException] → [AuthenticationFailure]
  /// - [NotFoundException] → [NotFoundFailure]
  /// - [RateLimitException] → [RateLimitFailure]
  /// - [ServerException] → [ServerFailure]
  /// - [BadRequestException] → [ValidationFailure]
  /// - Others → [ServerFailure]
  static Failure fromApiException(ApiException exception) {
    return switch (exception) {
      NetworkException() => Failure.network(message: exception.message),
      UnauthorizedException() =>
        Failure.authentication(message: exception.message),
      ForbiddenException() => Failure.authentication(
          message: exception.message,
        ),
      NotFoundException() => Failure.notFound(message: exception.message),
      RateLimitException() => Failure.rateLimit(message: exception.message),
      ServerException() => Failure.server(
          message: exception.message,
          statusCode: exception.statusCode,
        ),
      BadRequestException() => Failure.validation(message: exception.message),
      RequestCancelledException() => Failure.network(
          message: exception.message,
        ),
      UnknownApiException() => Failure.server(
          message: exception.message,
          statusCode: exception.statusCode,
        ),
    };
  }

  /// Maps an [AuthException] to a domain [Failure]
  ///
  /// Handles authentication-specific exceptions:
  /// - Token expired → [AuthenticationFailure] with session expired message
  /// - Invalid credentials → [AuthenticationFailure]
  /// - Generic auth errors → [AuthenticationFailure]
  static Failure fromAuthException(AuthException exception) {
    if (exception.isTokenExpired) {
      return Failure.authentication(
        message: 'Your session has expired. Please sign in again.',
      );
    }

    if (exception.isInvalidCredentials) {
      return Failure.authentication(
        message: 'Invalid credentials. Please check your API key or login details.',
      );
    }

    // Check status code for more specific handling
    return switch (exception.statusCode) {
      401 => Failure.authentication(message: exception.message),
      403 => Failure.authentication(
          message: 'Access denied. You do not have permission to perform this action.',
        ),
      _ => Failure.authentication(message: exception.message),
    };
  }

  /// Maps a [SessionException] to a domain [Failure]
  static Failure fromSessionException(SessionException exception) {
    return Failure.authentication(message: exception.message);
  }

  /// Maps any exception to a domain [Failure]
  ///
  /// Handles [ApiException], [AuthException], [SessionException], and generic exceptions.
  static Failure fromException(Object exception) {
    if (exception is ApiException) {
      return fromApiException(exception);
    }

    if (exception is AuthException) {
      return fromAuthException(exception);
    }

    if (exception is SessionException) {
      return fromSessionException(exception);
    }

    if (exception is CacheException) {
      return Failure.cache(message: exception.message);
    }

    if (exception is StorageException) {
      return Failure.cache(message: exception.message);
    }

    if (exception is ConfigurationException) {
      return Failure.unknown(
        message: exception.message,
        error: exception,
      );
    }

    return Failure.unknown(
      message: exception.toString(),
      error: exception,
    );
  }

  /// Maps an [ArgumentError] to a [ValidationFailure]
  static Failure fromArgumentError(ArgumentError error) {
    return Failure.validation(
      message: error.message?.toString() ?? 'Invalid argument',
    );
  }
}
