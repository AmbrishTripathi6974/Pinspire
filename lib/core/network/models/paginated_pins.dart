// ignore_for_file: invalid_annotation_target

/// Paginated pins result model
/// Domain-level wrapper for paginated photo responses
///
/// Uses Freezed for immutability and value equality.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

part 'paginated_pins.freezed.dart';
part 'paginated_pins.g.dart';

/// Paginated result containing a list of [Pin] objects
///
/// This is the domain-level response for all paginated photo endpoints.
/// It provides pagination metadata and helper methods for navigating pages.
///
/// Example usage:
/// ```dart
/// final result = await pexelsApiService.getCuratedPhotos(page: 1);
/// if (result.hasNextPage) {
///   final nextResult = await pexelsApiService.getCuratedPhotos(
///     page: result.nextPage!,
///   );
/// }
/// ```
@freezed
class PaginatedPins with _$PaginatedPins {
  const PaginatedPins._();

  const factory PaginatedPins({
    /// List of pins for the current page
    required List<Pin> pins,

    /// Current page number (1-indexed)
    required int page,

    /// Number of items per page
    required int perPage,

    /// Total number of results available
    required int totalResults,

    /// Whether there are more pages available
    required bool hasNextPage,

    /// URL to fetch the next page (if available)
    String? nextPageUrl,

    /// URL to fetch the previous page (if available)
    String? prevPageUrl,
  }) = _PaginatedPins;

  factory PaginatedPins.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPinsFromJson(json);

  /// Calculate the next page number, or null if no more pages
  int? get nextPage => hasNextPage ? page + 1 : null;

  /// Calculate the previous page number, or null if on first page
  int? get prevPage => page > 1 ? page - 1 : null;

  /// Whether there are previous pages available
  bool get hasPrevPage => page > 1;

  /// Total number of pages available
  int get totalPages => perPage > 0 ? (totalResults / perPage).ceil() : 0;

  /// Whether this is the first page
  bool get isFirstPage => page == 1;

  /// Whether this is the last page
  bool get isLastPage => !hasNextPage;

  /// Whether the result is empty
  bool get isEmpty => pins.isEmpty;

  /// Whether the result is not empty
  bool get isNotEmpty => pins.isNotEmpty;

  /// Number of pins in the current page
  int get count => pins.length;

  /// Creates an empty paginated result
  factory PaginatedPins.empty() => const PaginatedPins(
        pins: [],
        page: 1,
        perPage: 0,
        totalResults: 0,
        hasNextPage: false,
      );
}
