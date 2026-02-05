// Hero carousel widget
// Full-bleed editorial hero images with overlay text

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({
    super.key,
    required this.items,
    required this.topPadding,
    this.autoScrollDuration = const Duration(seconds: 5),
    this.onItemTap,
  });

  final List<HeroItem> items;
  final double topPadding;
  final Duration autoScrollDuration;
  final void Function(HeroItem item)? onItemTap;

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.items.length <= 1) return;

    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!mounted) return;

      final nextPage = (_currentPage + 1) % widget.items.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return SizedBox(height: 320 + widget.topPadding);
    }

    // Total height includes top padding for status bar + search bar space
    final totalHeight = 320 + widget.topPadding;

    return Column(
      children: [
        // Hero image area
        SizedBox(
          height: totalHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.items.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return GestureDetector(
                onTap: () => widget.onItemTap?.call(item),
                child: _HeroSlide(
                  item: item,
                  topPadding: widget.topPadding,
                ),
              );
            },
          ),
        ),

        // Page indicator dots
        const SizedBox(height: 12),
        _PageIndicator(
          itemCount: widget.items.length,
          currentPage: _currentPage,
        ),
      ],
    );
  }
}

class _HeroSlide extends StatelessWidget {
  const _HeroSlide({
    required this.item,
    required this.topPadding,
  });

  final HeroItem item;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Full bleed background image
        PinterestCachedImage(
          imageUrl: item.imageUrl,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: placeholderColor),
          errorWidget: (_, __, ___) => Container(
            color: placeholderColor,
            child: Center(child: FaIcon(FontAwesomeIcons.image, color: isDark ? Colors.grey.shade600 : Colors.grey)),
          ),
          memCacheWidth: 900,
          memCacheHeight: 1200,
          filterQuality: FilterQuality.high,
        ),

        // Gradient overlay at bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 180,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),

        // Text content at bottom
        Positioned(
          left: 16,
          right: 16,
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subtitle
              Text(
                item.subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              // Headline
              Text(
                item.headline,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.itemCount,
    required this.currentPage,
  });

  final int itemCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    if (itemCount <= 1) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = isDark ? Colors.white : Colors.black;
    final inactiveColor = isDark ? Colors.grey.shade600 : Colors.grey.shade400;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentPage;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}

/// Shimmer placeholder for hero carousel
class HeroCarouselShimmer extends StatelessWidget {
  const HeroCarouselShimmer({
    super.key,
    this.topPadding = 0,
  });

  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shimmerColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final dotColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return Column(
      children: [
        Container(
          height: 320 + topPadding,
          color: shimmerColor,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            7,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
