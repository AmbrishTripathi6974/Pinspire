/// Dio interceptor for logging
/// Logs requests and responses for debugging

import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Interceptor that logs HTTP requests and responses
class ApiLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logError(err);
    handler.next(err);
  }

  void _logRequest(RequestOptions options) {
    developer.log(
      '┌──────────────────────────────────────────────────────────────────────────────────────────────────',
      name: 'HTTP',
    );
    developer.log(
      '│ REQUEST: ${options.method} ${options.uri}',
      name: 'HTTP',
    );

    if (options.queryParameters.isNotEmpty) {
      developer.log(
        '│ Query: ${options.queryParameters}',
        name: 'HTTP',
      );
    }

    if (options.data != null) {
      developer.log(
        '│ Body: ${options.data}',
        name: 'HTTP',
      );
    }

    developer.log(
      '└──────────────────────────────────────────────────────────────────────────────────────────────────',
      name: 'HTTP',
    );
  }

  void _logResponse(Response response) {
    developer.log(
      '┌──────────────────────────────────────────────────────────────────────────────────────────────────',
      name: 'HTTP',
    );
    developer.log(
      '│ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
      name: 'HTTP',
    );
    developer.log(
      '│ Data: ${_truncateData(response.data)}',
      name: 'HTTP',
    );
    developer.log(
      '└──────────────────────────────────────────────────────────────────────────────────────────────────',
      name: 'HTTP',
    );
  }

  void _logError(DioException err) {
    developer.log(
      '┌──────────────────────────────────────────────────────────────────────────────────────────────────',
      name: 'HTTP',
      level: 1000, // Warning level
    );
    developer.log(
      '│ ERROR: ${err.type} ${err.requestOptions.uri}',
      name: 'HTTP',
      level: 1000,
    );
    developer.log(
      '│ Message: ${err.message}',
      name: 'HTTP',
      level: 1000,
    );

    if (err.response != null) {
      developer.log(
        '│ Response: ${err.response?.statusCode} - ${err.response?.data}',
        name: 'HTTP',
        level: 1000,
      );
    }

    developer.log(
      '└──────────────────────────────────────────────────────────────────────────────────────────────────',
      name: 'HTTP',
      level: 1000,
    );
  }

  String _truncateData(dynamic data) {
    final str = data.toString();
    if (str.length > 500) {
      return '${str.substring(0, 500)}... [truncated]';
    }
    return str;
  }
}
