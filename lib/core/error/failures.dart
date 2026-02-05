/// Failure classes for Either pattern
/// Domain-level failure representations for error handling
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class for domain-level errors
/// 
/// Use with Either pattern for functional error handling:
/// ```dart
/// Future<Either<Failure, List<Pin>>> getCuratedPins();
/// ```
@freezed
sealed class Failure with _$Failure {
  /// Server or network-related failure
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  /// Network connectivity failure
  const factory Failure.network({
    required String message,
  }) = NetworkFailure;

  /// Cache or local storage failure
  const factory Failure.cache({
    required String message,
  }) = CacheFailure;

  /// Invalid input or validation failure
  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  /// Authentication failure (invalid API key, etc.)
  const factory Failure.authentication({
    required String message,
  }) = AuthenticationFailure;

  /// Resource not found failure
  const factory Failure.notFound({
    required String message,
  }) = NotFoundFailure;

  /// Rate limit exceeded failure
  const factory Failure.rateLimit({
    required String message,
  }) = RateLimitFailure;

  /// Unknown or unexpected failure
  const factory Failure.unknown({
    required String message,
    Object? error,
  }) = UnknownFailure;
}
