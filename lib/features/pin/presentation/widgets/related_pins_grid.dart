// related_pins_grid.dart
// Grid of related pins — same design as search results (MasonryGridView + FeedPinTile)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/utils/hero_tag_manager.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/home/presentation/widgets/feed_pin_tile.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_options_bottom_sheet.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_quick_action_overlay.dart';
import 'package:pinterest/features/home/presentation/widgets/save_to_nav_animation_overlay.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

/// Grid of related pins with same card design as search results.
class RelatedPinsGrid extends ConsumerWidget {
  const RelatedPinsGrid({
    super.key,
    required this.pins,
    this.isLoading = false,
  });

  final List<Pin> pins;
  final bool isLoading;

  void _showPinOptions(BuildContext context, WidgetRef ref, Pin pin) {
    PinOptionsBottomSheet.show(
      context: context,
      pin: pin,
      inspirationText: 'This Pin is related to what you\'re viewing.',
      onSave: () {
        if (!pin.saved && context.mounted) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: pin.imageUrl,
            startPosition: null,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
      },
      onShare: () => _showSnackBar(context, 'Share functionality coming soon'),
      onSeeMoreLikeThis: () => _showSnackBar(context, "We'll show you more pins like this"),
      onSeeLessLikeThis: () => _showSnackBar(context, "We'll show you fewer pins like this"),
      onReport: () => _showSnackBar(context, 'Report submitted. Thank you!'),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return SizedBox(
        height: 200,
        child: PinterestDotsLoader.centered(),
      );
    }

    if (pins.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 420,
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: pins.length,
        itemBuilder: (context, index) => _buildTile(context, ref, pins[index], index),
      ),
    );
  }

  Widget _buildTile(BuildContext context, WidgetRef ref, Pin pin, int index) {
    // Generate Hero tag for related pins
    final heroTag = HeroTagManager.generateTag(
      pinId: pin.id,
      context: HeroTagContext.relatedPins,
      index: index,
    );
    return FeedPinTile(
      key: ValueKey('related_pin_${pin.id}_$index'),
      pin: pin,
      heroTagContext: HeroTagContext.relatedPins,
      heroTagIndex: index,
      onTap: () => context.push(AppRoutes.pinViewerPath(pin.id, heroTag: heroTag)),
      onSave: () {
        if (!pin.saved && context.mounted) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: pin.imageUrl,
            startPosition: null,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
      },
      onSaveWithTouchPoint: (p, touchPoint) {
        if (!p.saved && context.mounted) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: p.imageUrl,
            startPosition: touchPoint,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(p);
      },
      onOptionsPressed: () => _showPinOptions(context, ref, pin),
      actionContext: PinQuickActionContext.homeFeed,
      showSaveIconOnImage: true,
      borderRadius: 8.0,
    );
  }
}

/// Sliver version of the related pins grid for use in CustomScrollView (whole screen scrollable).
class SliverRelatedPinsGrid extends ConsumerWidget {
  const SliverRelatedPinsGrid({
    super.key,
    required this.pins,
    this.isLoading = false,
  });

  final List<Pin> pins;
  final bool isLoading;

  void _showPinOptions(BuildContext context, WidgetRef ref, Pin pin) {
    PinOptionsBottomSheet.show(
      context: context,
      pin: pin,
      inspirationText: 'This Pin is related to what you\'re viewing.',
      onSave: () {
        if (!ref.read(savedPinsProvider).isPinSaved(pin.id) && context.mounted) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: pin.imageUrl,
            startPosition: null,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
      },
      onShare: () => _showSnackBar(context, 'Share functionality coming soon'),
      onSeeMoreLikeThis: () => _showSnackBar(context, "We'll show you more pins like this"),
      onSeeLessLikeThis: () => _showSnackBar(context, "We'll show you fewer pins like this"),
      onReport: () => _showSnackBar(context, 'Report submitted. Thank you!'),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildTile(BuildContext context, WidgetRef ref, Pin pin, int index) {
    // Generate Hero tag for related pins
    final heroTag = HeroTagManager.generateTag(
      pinId: pin.id,
      context: HeroTagContext.relatedPins,
      index: index,
    );
    return FeedPinTile(
      key: ValueKey('related_pin_${pin.id}_$index'),
      pin: pin,
      heroTagContext: HeroTagContext.relatedPins,
      heroTagIndex: index,
      onTap: () => context.push(AppRoutes.pinViewerPath(pin.id, heroTag: heroTag)),
      onSave: () {
        if (!pin.saved && context.mounted) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: pin.imageUrl,
            startPosition: null,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
      },
      onSaveWithTouchPoint: (p, touchPoint) {
        if (!p.saved && context.mounted) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: p.imageUrl,
            startPosition: touchPoint,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(p);
      },
      onOptionsPressed: () => _showPinOptions(context, ref, pin),
      actionContext: PinQuickActionContext.homeFeed,
      showSaveIconOnImage: true,
      borderRadius: 8.0,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: PinterestDotsLoader.centered(),
        ),
      );
    }

    if (pins.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childCount: pins.length,
        itemBuilder: (context, index) => _buildTile(context, ref, pins[index], index),
      ),
    );
  }
}
