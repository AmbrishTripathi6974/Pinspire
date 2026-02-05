/// Dio interceptor for Pexels API authentication
/// Adds Authorization header to all requests

import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Callback type for handling authentication errors
typedef AuthErrorCallback = void Function(AuthErrorType errorType, String message);

/// Types of authentication errors
enum AuthErrorType {
  /// API key is invalid or missing (401)
  invalidApiKey,
  /// Access is forbidden (403)
  forbidden,
  /// Rate limit exceeded (429)
  rateLimited,
}

/// Interceptor that adds the Pexels API key to request headers
/// and handles authentication-related errors
class PexelsAuthInterceptor extends Interceptor {
  PexelsAuthInterceptor({
    required String apiKey,
    this.onAuthError,
  }) : _apiKey = apiKey;

  final String _apiKey;

  /// Optional callback for authentication errors
  /// Use this to trigger UI updates (e.g., show error dialog, redirect to settings)
  final AuthErrorCallback? onAuthError;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Validate API key before making request
    if (_apiKey.isEmpty) {
      developer.log(
        'WARNING: Pexels API key is empty. Request will fail with 401.',
        name: 'PexelsAuthInterceptor',
        level: 900,
      );
    }

    // Add Authorization header with API key
    options.headers['Authorization'] = _apiKey;

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    switch (statusCode) {
      case 401:
        _handleUnauthorized(err);
        break;
      case 403:
        _handleForbidden(err);
        break;
      case 429:
        _handleRateLimited(err);
        break;
    }

    handler.next(err);
  }

  /// Handles 401 Unauthorized errors
  void _handleUnauthorized(DioException err) {
    const message = 'Invalid or missing Pexels API key. '
        'Please verify your API key in the .env file.';

    developer.log(
      'AUTH ERROR [401]: $message',
      name: 'PexelsAuthInterceptor',
      level: 1000,
      error: err,
    );

    developer.log(
      'Request URL: ${err.requestOptions.uri}',
      name: 'PexelsAuthInterceptor',
      level: 1000,
    );

    // Check if API key was actually sent
    final sentKey = err.requestOptions.headers['Authorization'];
    if (sentKey == null || (sentKey is String && sentKey.isEmpty)) {
      developer.log(
        'HINT: Authorization header was empty or missing.',
        name: 'PexelsAuthInterceptor',
        level: 1000,
      );
    } else {
      developer.log(
        'HINT: Authorization header was present but may be invalid. '
        'Key prefix: ${_maskApiKey(sentKey.toString())}',
        name: 'PexelsAuthInterceptor',
        level: 1000,
      );
    }

    onAuthError?.call(AuthErrorType.invalidApiKey, message);
  }

  /// Handles 403 Forbidden errors
  void _handleForbidden(DioException err) {
    const message = 'Access forbidden. Your API key may not have permission '
        'to access this resource.';

    developer.log(
      'AUTH ERROR [403]: $message',
      name: 'PexelsAuthInterceptor',
      level: 1000,
      error: err,
    );

    onAuthError?.call(AuthErrorType.forbidden, message);
  }

  /// Handles 429 Rate Limited errors
  void _handleRateLimited(DioException err) {
    // Extract rate limit headers if available
    final headers = err.response?.headers;
    final retryAfter = headers?.value('retry-after');
    final limitRemaining = headers?.value('x-ratelimit-remaining');

    final message = 'Rate limit exceeded. '
        '${retryAfter != null ? 'Retry after: $retryAfter seconds. ' : ''}'
        '${limitRemaining != null ? 'Remaining: $limitRemaining' : ''}';

    developer.log(
      'AUTH ERROR [429]: $message',
      name: 'PexelsAuthInterceptor',
      level: 1000,
      error: err,
    );

    onAuthError?.call(AuthErrorType.rateLimited, message.trim());
  }

  /// Masks an API key for logging (shows only first 8 chars)
  String _maskApiKey(String key) {
    if (key.length <= 8) return '***';
    return '${key.substring(0, 8)}...';
  }
}
