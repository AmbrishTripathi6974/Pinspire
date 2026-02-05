// related_pins_carousel.dart
// Horizontal scrollable carousel of related pins

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';

/// Horizontal scrollable carousel showing related pins
class RelatedPinsCarousel extends StatelessWidget {
  const RelatedPinsCarousel({
    super.key,
    required this.pins,
    this.isLoading = false,
  });

  final List<Pin> pins;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isLoading) {
      return SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: 100,
              height: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          },
        ),
      );
    }

    if (pins.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: pins.length,
        itemBuilder: (context, index) {
          final pin = pins[index];
          return _RelatedPinItem(pin: pin);
        },
      ),
    );
  }
}

/// Individual related pin item in the carousel
class _RelatedPinItem extends StatelessWidget {
  const _RelatedPinItem({required this.pin});

  final Pin pin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.pinViewerPath(pin.id));
      },
      child: Container(
        width: 100,
        height: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: PinterestCachedImage(
            imageUrl: pin.imageUrl,
            fit: BoxFit.cover,
            width: 100,
            height: 120,
            memCacheWidth: 200,
            memCacheHeight: 240,
            placeholder: (_, __) => Container(
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
            ),
            errorWidget: (_, __, ___) => Container(
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
              child: Icon(
                Icons.image,
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
