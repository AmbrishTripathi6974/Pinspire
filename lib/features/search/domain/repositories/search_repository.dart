// Abstract search repository contract
// Defines search operations interface

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';

/// Abstract repository interface for search operations
///
/// Implementations should handle:
/// - Remote API calls to search pins
/// - Search history management
/// - Search suggestions
abstract class SearchRepository {
  /// Searches pins by query string
  ///
  /// [query] - The search query (required, non-empty)
  /// [page] - The page number to fetch (1-indexed)
  /// [perPage] - Number of items per page
  ///
  /// Returns [Right] with [PaginatedPinsResult] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PaginatedPinsResult>> searchPins({
    required String query,
    required int page,
    int perPage = 15,
  });

  /// Gets search suggestions based on partial query
  ///
  /// [query] - Partial search query
  ///
  /// Returns [Right] with list of suggestions on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<String>>> getSearchSuggestions({
    required String query,
  });

  /// Gets recent search history
  ///
  /// Returns [Right] with list of recent searches on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<String>>> getRecentSearches();

  /// Clears search history
  Future<Either<Failure, Unit>> clearSearchHistory();
}
