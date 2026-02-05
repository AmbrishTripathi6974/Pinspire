// Idea boards section widget
// "Ideas you might like" with 2x2 collage-style cards

import 'package:flutter/material.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';

class IdeaBoardsSection extends StatelessWidget {
  const IdeaBoardsSection({
    super.key,
    required this.boards,
    this.onBoardTap,
  });

  final List<IdeaBoard> boards;
  final void Function(IdeaBoard board)? onBoardTap;

  @override
  Widget build(BuildContext context) {
    if (boards.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final titleColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore featured boards',
                style: TextStyle(
                  fontSize: 12,
                  color: subtitleColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Ideas you might like',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  color: titleColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Horizontal scrolling cards
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            itemCount: boards.length,
            itemBuilder: (context, index) {
              final board = boards[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _IdeaBoardCard(
                  board: board,
                  onTap: () => onBoardTap?.call(board),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _IdeaBoardCard extends StatelessWidget {
  const _IdeaBoardCard({
    required this.board,
    this.onTap,
  });

  final IdeaBoard board;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black;
    final creatorColor = isDark ? Colors.white : Colors.black;
    final metaColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2x2 Image collage grid
            SizedBox(
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _CollageGrid(imageUrls: board.imageUrls),
              ),
            ),
            const SizedBox(height: 8),

            // Title (multi-line)
            Text(
              board.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: titleColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Creator row with verified badge
            Row(
              children: [
                Flexible(
                  child: Text(
                    board.creator,
                    style: TextStyle(
                      fontSize: 12,
                      color: creatorColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (board.isVerified) ...[
                  const SizedBox(width: 4),
                  const _VerifiedBadge(),
                ],
              ],
            ),
            const SizedBox(height: 2),

            // Pin count and time
            Text(
              '${board.pinCount} Pins · ${board.timeAgo}',
              style: TextStyle(
                fontSize: 10,
                color: metaColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2x2 collage grid showing 4 images
class _CollageGrid extends StatelessWidget {
  const _CollageGrid({required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    if (imageUrls.isEmpty) {
      return Container(color: placeholderColor);
    }

    // If less than 4 images, show single image
    if (imageUrls.length < 4) {
      return _GridImage(imageUrl: imageUrls.first);
    }

    // 2x2 grid layout
    return Row(
      children: [
        // Left column - large image
        Expanded(
          flex: 1,
          child: _GridImage(imageUrl: imageUrls[0]),
        ),
        const SizedBox(width: 2),
        // Right column - 2 stacked images + 1 small
        Expanded(
          flex: 1,
          child: Column(
            children: [
              // Top right
              Expanded(
                child: _GridImage(imageUrl: imageUrls[1]),
              ),
              const SizedBox(height: 2),
              // Bottom right row
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _GridImage(imageUrl: imageUrls[2]),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: _GridImage(imageUrl: imageUrls[3]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GridImage extends StatelessWidget {
  const _GridImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final errorIconColor = isDark ? Colors.grey.shade600 : Colors.grey;

    return PinterestCachedImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (_, __) => Container(color: placeholderColor),
      errorWidget: (_, __, ___) => Container(
        color: placeholderColor,
        child: Center(child: FaIcon(FontAwesomeIcons.image, size: 14, color: errorIconColor)),
      ),
      memCacheWidth: 480,
      memCacheHeight: 480,
      filterQuality: FilterQuality.high,
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: Color(0xFFE60023),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const FaIcon(
        FontAwesomeIcons.check,
        color: Colors.white,
        size: 8,
      ),
    );
  }
}

/// Shimmer placeholder
class IdeaBoardsShimmer extends StatelessWidget {
  const IdeaBoardsShimmer({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 130,
                height: 12,
                decoration: BoxDecoration(
                  color: shimmerColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 160,
                height: 20,
                decoration: BoxDecoration(
                  color: shimmerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _ShimmerCard(shimmerColor: shimmerColor),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({required this.shimmerColor});

  final Color shimmerColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 140,
            height: 13,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 80,
            height: 12,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: 100,
            height: 12,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}
