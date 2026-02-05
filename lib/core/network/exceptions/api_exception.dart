import 'package:dio/dio.dart';

/// Base class for all API-related exceptions
sealed class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  final String message;
  final int? statusCode;
  final dynamic originalError;

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';

  /// Factory constructor to create appropriate exception from DioException
  factory ApiException.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timed out. Please check your internet connection.',
          originalError: error,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network settings.',
          originalError: error,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Security certificate error.',
          originalError: error,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return RequestCancelledException(
          message: 'Request was cancelled.',
          originalError: error,
        );

      case DioExceptionType.unknown:
        return UnknownApiException(
          message: error.message ?? 'An unexpected error occurred.',
          originalError: error,
        );
    }
  }

  static ApiException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    String message = 'Request failed';
    if (responseData is Map<String, dynamic>) {
      message = responseData['error'] as String? ??
          responseData['message'] as String? ??
          message;
    }

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message,
          statusCode: statusCode,
          originalError: error,
        );
      case 401:
        return UnauthorizedException(
          message: 'Invalid API key. Please check your Pexels API key.',
          statusCode: statusCode,
          originalError: error,
        );
      case 403:
        return ForbiddenException(
          message: 'Access denied. You do not have permission to access this resource.',
          statusCode: statusCode,
          originalError: error,
        );
      case 404:
        return NotFoundException(
          message: 'The requested resource was not found.',
          statusCode: statusCode,
          originalError: error,
        );
      case 429:
        return RateLimitException(
          message: 'Rate limit exceeded. Please try again later.',
          statusCode: statusCode,
          originalError: error,
        );
      case final code when code != null && code >= 500:
        return ServerException(
          message: 'Server error. Please try again later.',
          statusCode: code,
          originalError: error,
        );
      default:
        return UnknownApiException(
          message: message,
          statusCode: statusCode,
          originalError: error,
        );
    }
  }
}

/// Network-related exceptions (timeout, no internet, etc.)
final class NetworkException extends ApiException {
  const NetworkException({
    required super.message,
    super.originalError,
  }) : super(statusCode: null);
}

/// 400 Bad Request
final class BadRequestException extends ApiException {
  const BadRequestException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// 401 Unauthorized - Invalid or missing API key
final class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// 403 Forbidden
final class ForbiddenException extends ApiException {
  const ForbiddenException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// 404 Not Found
final class NotFoundException extends ApiException {
  const NotFoundException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// 429 Too Many Requests - Rate limiting
final class RateLimitException extends ApiException {
  const RateLimitException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// 5xx Server Errors
final class ServerException extends ApiException {
  const ServerException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Request was cancelled
final class RequestCancelledException extends ApiException {
  const RequestCancelledException({
    required super.message,
    super.originalError,
  }) : super(statusCode: null);
}

/// Unknown/unhandled API exception
final class UnknownApiException extends ApiException {
  const UnknownApiException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}
