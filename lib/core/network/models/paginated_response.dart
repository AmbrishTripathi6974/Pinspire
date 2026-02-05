// ignore_for_file: invalid_annotation_target

// Paginated response model for Pexels API
// Wraps list responses with pagination metadata

import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response.freezed.dart';
part 'paginated_response.g.dart';

/// Generic paginated response wrapper for Pexels API
/// 
/// Pexels API returns responses in this format:
/// ```json
/// {
///   "page": 1,
///   "per_page": 15,
///   "total_results": 8000,
///   "next_page": "https://api.pexels.com/v1/curated?page=2&per_page=15",
///   "prev_page": null,
///   "photos": [...]
/// }
/// ```
@freezed
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const PaginatedResponse._();

  const factory PaginatedResponse({
    required int page,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
    @JsonKey(name: 'prev_page') String? prevPage,
    required List<T> photos,
  }) = _PaginatedResponse<T>;

  /// Whether there are more pages available
  bool get hasNextPage => nextPage != null;

  /// Whether there are previous pages
  bool get hasPrevPage => prevPage != null;

  /// Calculate total number of pages
  int get totalPages => (totalResults / perPage).ceil();

  /// Whether this is the last page
  bool get isLastPage => page >= totalPages;
}

/// Non-generic version for JSON serialization with raw maps
@freezed
class PaginatedPhotoResponse with _$PaginatedPhotoResponse {
  const PaginatedPhotoResponse._();

  const factory PaginatedPhotoResponse({
    required int page,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
    @JsonKey(name: 'prev_page') String? prevPage,
    required List<Map<String, dynamic>> photos,
  }) = _PaginatedPhotoResponse;

  factory PaginatedPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPhotoResponseFromJson(json);

  /// Whether there are more pages available
  bool get hasNextPage => nextPage != null;

  /// Whether there are previous pages
  bool get hasPrevPage => prevPage != null;

  /// Calculate total number of pages
  int get totalPages => perPage > 0 ? (totalResults / perPage).ceil() : 0;

  /// Whether this is the last page
  bool get isLastPage => page >= totalPages;
}
