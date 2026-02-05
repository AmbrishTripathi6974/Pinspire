// Feed repository implementation
// Coordinates remote fetching with local caching

import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/core/network/exceptions/api_exception.dart';
import 'package:pinterest/core/network/services/pexels_api_service.dart';
import 'package:pinterest/core/network/utils/failure_mapper.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// Implementation of [FeedRepository] using Pexels API
///
/// Handles:
/// - Fetching curated photos from Pexels API
/// - Converting API responses to domain models
/// - Error handling and failure mapping
/// - Pinterest-style refresh with fresh content
class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl({
    required PexelsApiService apiService,
  }) : _apiService = apiService;

  final PexelsApiService _apiService;
  final Random _random = Random();
  
  /// Track last refresh page to avoid showing same content
  int _lastRefreshPage = 0;
  
  /// Trending topics for variety in refresh
  static const _trendingTopics = [
    'nature',
    'architecture',
    'food',
    'travel',
    'fashion',
    'art',
    'animals',
    'technology',
    'flowers',
    'sunset',
    'ocean',
    'mountains',
    'city',
    'minimal',
    'vintage',
  ];

  @override
  Future<Either<Failure, PaginatedPinsResult>> getHomePins({
    required int page,
    int perPage = 15,
  }) async {
    try {
      final result = await _apiService.getCuratedPhotos(
        page: page,
        perPage: perPage,
      );

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
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, PaginatedPinsResult>> refreshHomePins({
    int perPage = 15,
  }) async {
    try {
      // Pinterest-style refresh: Mix curated photos with trending topic search
      // This gives users fresh, different content on each pull-to-refresh
      
      final List<Pin> refreshedPins = [];
      
      // Strategy: Fetch from a random page of curated + a random trending topic
      // This ensures users see different content on each refresh
      
      // 1. Get curated photos from a random page (not the same as last refresh)
      int randomPage = _random.nextInt(50) + 1; // Pages 1-50
      while (randomPage == _lastRefreshPage && randomPage != 1) {
        randomPage = _random.nextInt(50) + 1;
      }
      _lastRefreshPage = randomPage;
      
      final curatedResult = await _apiService.getCuratedPhotos(
        page: randomPage,
        perPage: (perPage * 0.6).ceil(), // 60% from curated
      );
      refreshedPins.addAll(curatedResult.pins);
      
      // 2. Add some photos from a random trending topic for variety
      final randomTopic = _trendingTopics[_random.nextInt(_trendingTopics.length)];
      try {
        final searchResult = await _apiService.searchPhotos(
          query: randomTopic,
          page: _random.nextInt(10) + 1, // Random page 1-10
          perPage: (perPage * 0.4).ceil(), // 40% from search
        );
        refreshedPins.addAll(searchResult.pins);
      } catch (_) {
        // If search fails, just use curated photos
        // Fetch more curated to compensate
        final moreCurated = await _apiService.getCuratedPhotos(
          page: randomPage + 1,
          perPage: (perPage * 0.4).ceil(),
        );
        refreshedPins.addAll(moreCurated.pins);
      }
      
      // 3. Shuffle the combined results for a fresh feel
      refreshedPins.shuffle(_random);
      
      // 4. Remove duplicates (by ID)
      final seenIds = <String>{};
      final uniquePins = refreshedPins.where((pin) {
        if (seenIds.contains(pin.id)) return false;
        seenIds.add(pin.id);
        return true;
      }).toList();

      return Right(
        PaginatedPinsResult(
          pins: uniquePins,
          page: 1, // Reset to page 1 for pagination purposes
          hasNextPage: true,
          totalResults: curatedResult.totalResults,
        ),
      );
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
