/// Pexels API Service
/// Stateless service for Pexels API endpoints
/// Maps API responses to domain Pin models
///
/// This service is responsible for:
/// - Making HTTP requests to the Pexels API
/// - Parsing JSON responses into domain models
/// - Providing pagination support
/// - Throwing [ApiException] on failures
///
/// Usage:
/// ```dart
/// final service = PexelsApiService(dio: getIt<Dio>());
/// final result = await service.getCuratedPhotos(page: 1);
/// ```
///
/// Error handling is done at the repository layer, where [ApiException]
/// is mapped to domain [Failure] types using [FailureMapper].

import 'package:dio/dio.dart';
import 'package:pinterest/core/network/api_endpoints.dart';
import 'package:pinterest/core/network/exceptions/api_exception.dart';
import 'package:pinterest/core/network/models/paginated_pins.dart';
import 'package:pinterest/core/network/models/paginated_response.dart';
import 'package:pinterest/core/utils/constants/api_constants.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// Stateless service for interacting with the Pexels API
/// 
/// This service provides methods to:
/// - Fetch curated photos (home feed)
/// - Search photos by query
/// 
/// All methods map Pexels API responses to domain [Pin] models.
class PexelsApiService {
  const PexelsApiService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  /// Fetches curated photos from Pexels
  /// 
  /// Used for the home feed to show popular/trending photos.
  /// 
  /// [page] - The page number to fetch (1-indexed)
  /// [perPage] - Number of items per page (max 80, default 15)
  /// 
  /// Returns [PaginatedPins] containing the list of pins and pagination info.
  /// 
  /// Throws [ApiException] subclasses on failure.
  Future<PaginatedPins> getCuratedPhotos({
    int page = 1,
    int perPage = ApiConstants.defaultPerPage,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.curated,
        queryParameters: {
          'page': page,
          'per_page': perPage.clamp(1, ApiConstants.maxPerPage),
        },
      );

      return _parsePaginatedResponse(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Searches photos on Pexels by query
  /// 
  /// [query] - The search query string (required, non-empty)
  /// [page] - The page number to fetch (1-indexed)
  /// [perPage] - Number of items per page (max 80, default 15)
  /// [orientation] - Filter by orientation: 'landscape', 'portrait', 'square'
  /// [size] - Filter by size: 'large', 'medium', 'small'
  /// [color] - Filter by color (hex code without # or color name)
  /// [locale] - Locale for search (e.g., 'en-US', 'pt-BR')
  /// 
  /// Returns [PaginatedPins] containing the list of pins and pagination info.
  /// 
  /// Throws [ApiException] subclasses on failure.
  /// Throws [ArgumentError] if query is empty.
  Future<PaginatedPins> searchPhotos({
    required String query,
    int page = 1,
    int perPage = ApiConstants.defaultPerPage,
    String? orientation,
    String? size,
    String? color,
    String? locale,
  }) async {
    if (query.trim().isEmpty) {
      throw ArgumentError.value(query, 'query', 'Search query cannot be empty');
    }

    try {
      final queryParameters = <String, dynamic>{
        'query': query.trim(),
        'page': page,
        'per_page': perPage.clamp(1, ApiConstants.maxPerPage),
      };

      // Add optional filters
      if (orientation != null) {
        queryParameters['orientation'] = orientation;
      }
      if (size != null) {
        queryParameters['size'] = size;
      }
      if (color != null) {
        queryParameters['color'] = color;
      }
      if (locale != null) {
        queryParameters['locale'] = locale;
      }

      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.search,
        queryParameters: queryParameters,
      );

      return _parsePaginatedResponse(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Fetches a single photo by ID
  ///
  /// [id] - The Pexels photo ID
  ///
  /// Returns the [Pin] domain model for the photo.
  ///
  /// Throws [ApiException] subclasses on failure.
  /// Throws [ArgumentError] if id is empty.
  Future<Pin> getPhotoById({required String id}) async {
    if (id.trim().isEmpty) {
      throw ArgumentError.value(id, 'id', 'Photo ID cannot be empty');
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.photo(id.trim()),
      );

      return Pin.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Parses the paginated response and maps photos to Pin domain models
  PaginatedPins _parsePaginatedResponse(Map<String, dynamic> data) {
    final paginatedResponse = PaginatedPhotoResponse.fromJson(data);

    final pins = paginatedResponse.photos
        .map((photoJson) => Pin.fromJson(photoJson))
        .toList();

    return PaginatedPins(
      pins: pins,
      page: paginatedResponse.page,
      perPage: paginatedResponse.perPage,
      totalResults: paginatedResponse.totalResults,
      hasNextPage: paginatedResponse.hasNextPage,
      nextPageUrl: paginatedResponse.nextPage,
      prevPageUrl: paginatedResponse.prevPage,
    );
  }
}
