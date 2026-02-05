// Pinterest-style image cache manager
// Production-optimized disk cache: same URL never refetches unnecessarily.
// Survives tab switch, scroll recycling, and navigation.

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Global cache manager for all app images.
///
/// Production-optimized Pinterest-style behavior:
/// - Disk cache preferred: 30-day retention, 1000 objects (increased for better UX)
/// - Same image URL uses stable cache key (URL)
/// - No aggressive eviction; images survive app backgrounding
/// - Single instance so all CachedNetworkImage widgets share cache
/// - Optimized for Pinterest-style heavy image usage
final pinterestCacheManager = CacheManager(
  Config(
    'pinterest_images',
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 1000, // Increased from 500 for better cache hit rate
    repo: JsonCacheInfoRepository(databaseName: 'pinterest_images.db'),
    fileService: HttpFileService(),
  ),
);
