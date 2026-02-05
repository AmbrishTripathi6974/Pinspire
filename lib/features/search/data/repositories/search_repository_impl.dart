// Search repository implementation
// Handles search API calls and search history management

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/core/network/exceptions/api_exception.dart';
import 'package:pinterest/core/network/services/pexels_api_service.dart';
import 'package:pinterest/core/network/utils/failure_mapper.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';
import 'package:pinterest/features/search/domain/repositories/search_repository.dart';

/// Storage keys for search history
abstract class _StorageKeys {
  static const String recentSearches = 'recent_searches';
  static const int maxRecentSearches = 20;
}

/// Implementation of [SearchRepository] using Pexels API
///
/// Handles:
/// - Searching photos via Pexels API
/// - Managing search history in local storage
/// - Search suggestions based on history
class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl({
    required PexelsApiService apiService,
    required LocalStorageService localStorage,
  })  : _apiService = apiService,
        _localStorage = localStorage;

  final PexelsApiService _apiService;
  final LocalStorageService _localStorage;

  @override
  Future<Either<Failure, PaginatedPinsResult>> searchPins({
    required String query,
    required int page,
    int perPage = 15,
  }) async {
    try {
      final result = await _apiService.searchPhotos(
        query: query,
        page: page,
        perPage: perPage,
      );

      // Save to recent searches on first page
      if (page == 1) {
        await _addToRecentSearches(query);
      }

      return Right(
        PaginatedPinsResult(
          pins: result.pins,
          page: result.page,
          hasNextPage: result.hasNextPage,
          totalResults: result.totalResults,
        ),
      );
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } on ArgumentError catch (e) {
      return Left(FailureMapper.fromArgumentError(e));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSearchSuggestions({
    required String query,
  }) async {
    try {
      // Get suggestions from recent searches that match the query
      final recentSearches = _localStorage.getStringList(
            _StorageKeys.recentSearches,
          ) ??
          [];

      final normalizedQuery = query.toLowerCase().trim();
      final suggestions = recentSearches
          .where((search) => search.toLowerCase().contains(normalizedQuery))
          .take(5)
          .toList();

      return Right(suggestions);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to get search suggestions'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    try {
      final searches = _localStorage.getStringList(
            _StorageKeys.recentSearches,
          ) ??
          [];
      return Right(searches);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to get recent searches'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearSearchHistory() async {
    try {
      await _localStorage.remove(_StorageKeys.recentSearches);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to clear search history'));
    }
  }

  /// Adds a search query to recent searches
  Future<void> _addToRecentSearches(String query) async {
    try {
      final searches = _localStorage.getStringList(
            _StorageKeys.recentSearches,
          ) ??
          [];

      // Remove if already exists (to move to top)
      searches.remove(query);

      // Add to beginning
      searches.insert(0, query);

      // Limit to max recent searches
      final trimmed = searches.take(_StorageKeys.maxRecentSearches).toList();

      await _localStorage.setStringList(_StorageKeys.recentSearches, trimmed);
    } catch (_) {
      // Silently fail - search history is not critical
    }
  }
}
