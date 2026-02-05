// Pinterest-style cached image widget
// Centralized image loading: stable cache key, disk cache, RepaintBoundary.
// Fade only on first load; cached images appear instantly.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/core/cache/pinterest_cache_manager.dart';

/// Pinterest-style cached network image.
///
/// - Uses [pinterestCacheManager] (disk + memory)
/// - Cache key = URL so same image never refetches
/// - Wrapped in [RepaintBoundary] to avoid rebuild-triggered repaints
/// - Short fade (100ms) for first load; cached served from disk without refetch
/// - Optional [memCacheWidth]/[memCacheHeight] for memory control
class PinterestCachedImage extends StatelessWidget {
  const PinterestCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.memCacheWidth,
    this.memCacheHeight,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    /// Fade duration when image loads from network. Short so cached feels instant.
    this.fadeInDuration = const Duration(milliseconds: 100),
    this.fadeOutDuration = const Duration(milliseconds: 100),
    this.filterQuality = FilterQuality.medium,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final BorderRadius? borderRadius;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    final child = CachedNetworkImage(
      imageUrl: imageUrl,
      cacheKey: imageUrl,
      cacheManager: pinterestCacheManager,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      filterQuality: filterQuality,
    );

    final wrapped = borderRadius != null
        ? ClipRRect(
            borderRadius: borderRadius!,
            child: child,
          )
        : child;

    return RepaintBoundary(
      child: wrapped,
    );
  }
}
