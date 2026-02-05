// Abstract feed repository contract
// Defines feed operations interface

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// Result type for paginated feed responses
class PaginatedPinsResult {
  const PaginatedPinsResult({
    required this.pins,
    required this.page,
    required this.hasNextPage,
    required this.totalResults,
  });

  final List<Pin> pins;
  final int page;
  final bool hasNextPage;
  final int totalResults;
}

/// Abstract repository interface for home feed operations
///
/// Implementations should handle:
/// - Remote API calls to fetch curated/home pins
/// - Local caching for offline support
/// - Pagination state management
abstract class FeedRepository {
  /// Fetches paginated home feed pins
  ///
  /// [page] - The page number to fetch (1-indexed)
  /// [perPage] - Number of items per page
  ///
  /// Returns [Right] with [PaginatedPinsResult] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PaginatedPinsResult>> getHomePins({
    required int page,
    int perPage = 15,
  });

  /// Refreshes the home feed (fetches first page)
  ///
  /// Clears any cached data and fetches fresh content
  Future<Either<Failure, PaginatedPinsResult>> refreshHomePins({
    int perPage = 15,
  });
}
