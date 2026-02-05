// masonry_skeleton.dart
// Skeleton loader for masonry grid layout
// Pinterest-style: top tab placeholders + staggered pin cards with optional menu dot

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/core/widgets/loading/shimmer_loader.dart';

/// Pinterest-style masonry skeleton: top bar placeholders + 2-column grid
/// of pin-like shimmer cards. Matches original Pinterest loading layout.
class MasonrySkeleton extends StatelessWidget {
  const MasonrySkeleton({
    super.key,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding = const EdgeInsets.all(8.0),
    this.itemCount = 18,
    this.borderRadius = 10.0,
  });

  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;
  final int itemCount;
  final double borderRadius;

  /// Pin heights (dp) – mix of tall image pins and shorter text-style pins
  static const List<double> _heights = [
    200, 260, 160, 220, 85, 190, 240, 170, 90, 210,
    180, 195, 75, 230, 165, 205, 155, 200,
  ];

  /// Indices that get a three-dot menu placeholder (top-right)
  static const List<int> _menuDotIndices = [0, 2, 4, 6, 8, 10, 12, 14, 16];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    // Muted, slightly warm greys like Pinterest
    final baseColor = isDark
        ? Color.lerp(Colors.grey.shade800, const Color(0xFF2A2A28), 0.3)!
        : Color.lerp(Colors.grey.shade200, const Color(0xFFE8E6E4), 0.5)!;
    final highlightColor = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade100;

    return ShimmerProvider(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top bar: two horizontal tab-like placeholders
          _TopBarSkeleton(
            baseColor: baseColor,
            highlightColor: highlightColor,
            backgroundColor: scaffoldBg,
          ),
          // Masonry grid of pin-style cards
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              padding: padding,
              itemCount: itemCount,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              itemBuilder: (context, index) {
                final height = _heights[index % _heights.length];
                final showMenuDot = _menuDotIndices.contains(index % 18);
                return _PinSkeletonCard(
                  height: height,
                  borderRadius: borderRadius,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  showMenuDot: showMenuDot,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Top bar with two horizontal rounded placeholders (tabs / categories)
class _TopBarSkeleton extends StatelessWidget {
  const _TopBarSkeleton({
    required this.baseColor,
    required this.highlightColor,
    required this.backgroundColor,
  });

  final Color baseColor;
  final Color highlightColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      color: backgroundColor,
      child: Row(
        children: [
          ShimmerLoader(
            width: 88,
            height: 24,
            borderRadius: 12,
            baseColor: baseColor,
            highlightColor: highlightColor,
          ),
          const SizedBox(width: 12),
          ShimmerLoader(
            width: 72,
            height: 24,
            borderRadius: 12,
            baseColor: baseColor,
            highlightColor: highlightColor,
          ),
        ],
      ),
    );
  }
}

/// Single pin-style skeleton: image area + optional three-dot placeholder
class _PinSkeletonCard extends StatelessWidget {
  const _PinSkeletonCard({
    required this.height,
    required this.borderRadius,
    required this.baseColor,
    required this.highlightColor,
    this.showMenuDot = true,
  });

  final double height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  final bool showMenuDot;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ShimmerLoader(
              height: height,
              borderRadius: borderRadius,
              baseColor: baseColor,
              highlightColor: highlightColor,
            ),
            if (showMenuDot)
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: ShimmerLoader(
                  width: 24,
                  height: 24,
                  borderRadius: 12,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
              ),
          ],
        ),
        // Thin bar below image (dots area) for taller pins
        if (height > 100) ...[
          const SizedBox(height: 6),
          ShimmerLoader(
            height: 20,
            borderRadius: 4,
            baseColor: baseColor,
            highlightColor: highlightColor,
          ),
        ],
      ],
    );
  }
}
