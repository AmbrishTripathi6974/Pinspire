// Popular category section widget
// "Popular on Pinterest" / "Ideas for you" – first 4 images in a rounded container

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';

/// Number of image slots in the section (images + placeholders).
const int _kMaxImagesInSection = 4;

/// Single-line spacing between images inside the container.
const double _kImageGap = 2;

/// Corner radius of the outer container.
const double _kContainerRadius = 16;

/// Height of the 4-image row.
const double _kRowHeight = 150;

class PopularCategorySection extends StatelessWidget {
  const PopularCategorySection({
    super.key,
    required this.category,
    this.onTap,
    this.sectionLabel = 'Popular on Pinterest',
  });

  final DiscoverCategory category;
  final VoidCallback? onTap;
  final String sectionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtitleColor = isDark ? Colors.white : Colors.black;
    final titleColor = isDark ? Colors.white : Colors.black;
    final buttonBgColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final buttonIconColor = isDark ? Colors.white : Colors.black;

    // First 4 image URLs; fill with null for placeholders
    final urls = category.imageUrls;
    final slots = List<String?>.generate(
      _kMaxImagesInSection,
      (i) => i < urls.length ? urls[i] : null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header with search button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sectionLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: subtitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: buttonBgColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(LucideIcons.search, size: 20, color: buttonIconColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),

        // Single container: first 4 images in one row, minimal spacing, rounded corners
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_kContainerRadius),
            child: Container(
              height: _kRowHeight,
              color: isDark ? Colors.black : Colors.white,
              child: Row(
                children: [
                  for (int i = 0; i < _kMaxImagesInSection; i++) ...[
                    if (i > 0) SizedBox(width: _kImageGap),
                    Expanded(
                      child: slots[i] != null
                          ? _CategoryImage(
                              imageUrl: slots[i]!,
                              onTap: onTap,
                            )
                          : _PlaceholderSlot(isDark: isDark),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Greyish placeholder when fewer than 4 images.
class _PlaceholderSlot extends StatelessWidget {
  const _PlaceholderSlot({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final color = isDark ? Colors.grey.shade700 : Colors.grey.shade400;
    return Container(
      color: color,
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.image,
          size: 24,
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
        ),
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  const _CategoryImage({
    required this.imageUrl,
    this.onTap,
  });

  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade400;
    final errorIconColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return GestureDetector(
      onTap: onTap,
      child: PinterestCachedImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (_, __) => Container(
          color: placeholderColor,
        ),
        errorWidget: (_, __, ___) => Container(
          color: placeholderColor,
          child: Center(
            child: FaIcon(FontAwesomeIcons.image, color: errorIconColor),
          ),
        ),
        memCacheWidth: 400,
        memCacheHeight: 400,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

/// Multiple categories list
class PopularCategoriesList extends StatelessWidget {
  const PopularCategoriesList({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.sectionLabel,
  });

  final List<DiscoverCategory> categories;
  final void Function(DiscoverCategory category)? onCategoryTap;
  /// When set, used as the small label for each section (e.g. "Ideas for you").
  final String? sectionLabel;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PopularCategorySection(
            category: category,
            onTap: () => onCategoryTap?.call(category),
            sectionLabel: sectionLabel ?? 'Popular on Pinterest',
          ),
        );
      }).toList(),
    );
  }
}

/// Shimmer placeholder for the 4-image rounded container.
class PopularCategoryShimmer extends StatelessWidget {
  const PopularCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shimmerColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 110,
                      height: 12,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 120,
                      height: 20,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: shimmerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_kContainerRadius),
            child: Container(
              height: _kRowHeight,
              color: isDark ? Colors.black : Colors.white,
              child: Row(
                children: [
                  for (int i = 0; i < _kMaxImagesInSection; i++) ...[
                    if (i > 0) SizedBox(width: _kImageGap),
                    Expanded(
                      child: Container(color: shimmerColor),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
