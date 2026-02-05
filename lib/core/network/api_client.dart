/// Dio HTTP client configuration
/// Base client setup with interceptors and error handling

import 'package:dio/dio.dart';
import 'package:pinterest/core/network/interceptors/auth_interceptor.dart';
import 'package:pinterest/core/network/interceptors/logging_interceptor.dart';
import 'package:pinterest/core/utils/constants/api_constants.dart';

/// Creates and configures a Dio instance for the Pexels API
class ApiClient {
  ApiClient({required String apiKey}) : _apiKey = apiKey;

  final String _apiKey;
  Dio? _dio;

  /// Returns the configured Dio instance
  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        responseType: ResponseType.json,
      ),
    );

    // Add interceptors in order of execution
    dio.interceptors.addAll([
      PexelsAuthInterceptor(apiKey: _apiKey),
      ApiLoggingInterceptor(),
    ]);

    return dio;
  }
}
