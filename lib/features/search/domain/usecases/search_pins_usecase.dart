// SearchPins use case
// Searches pins by query with pagination support

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';
import 'package:pinterest/features/search/domain/repositories/search_repository.dart';

/// Parameters for searching pins
class SearchPinsParams {
  const SearchPinsParams({
    required this.query,
    required this.page,
    this.perPage = 15,
  });

  final String query;
  final int page;
  final int perPage;

  /// Creates params for initial search (first page)
  factory SearchPinsParams.initial({
    required String query,
    int perPage = 15,
  }) =>
      SearchPinsParams(
        query: query,
        page: 1,
        perPage: perPage,
      );

  /// Creates params for next page of same search
  SearchPinsParams nextPage() => SearchPinsParams(
        query: query,
        page: page + 1,
        perPage: perPage,
      );

  /// Normalized query (trimmed and lowercased for comparison)
  String get normalizedQuery => query.trim().toLowerCase();
}

/// Use case for searching pins by query
///
/// This use case handles:
/// - Searching pins with a text query
/// - Pagination for search results
/// - Query validation
///
/// Example usage:
/// ```dart
/// final useCase = SearchPinsUseCase(repository: searchRepository);
/// final result = await useCase(SearchPinsParams.initial(query: 'nature'));
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (pinsResult) => print('Found ${pinsResult.totalResults} results'),
/// );
/// ```
class SearchPinsUseCase {
  const SearchPinsUseCase({
    required SearchRepository repository,
  }) : _repository = repository;

  final SearchRepository _repository;

  /// Executes the use case
  ///
  /// [params] - Contains search query, page number, and items per page
  ///
  /// Returns [Right] with [PaginatedPinsResult] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PaginatedPinsResult>> call(
    SearchPinsParams params,
  ) async {
    // Validate query is not empty
    final trimmedQuery = params.query.trim();
    if (trimmedQuery.isEmpty) {
      return const Left(
        Failure.validation(message: 'Search query cannot be empty'),
      );
    }

    // Validate query length (reasonable minimum)
    if (trimmedQuery.length < 2) {
      return const Left(
        Failure.validation(
          message: 'Search query must be at least 2 characters',
        ),
      );
    }

    // Validate page parameter
    if (params.page < 1) {
      return const Left(
        Failure.validation(message: 'Page number must be at least 1'),
      );
    }

    // Validate perPage parameter
    if (params.perPage < 1 || params.perPage > 80) {
      return const Left(
        Failure.validation(message: 'Items per page must be between 1 and 80'),
      );
    }

    return _repository.searchPins(
      query: trimmedQuery,
      page: params.page,
      perPage: params.perPage,
    );
  }
}
