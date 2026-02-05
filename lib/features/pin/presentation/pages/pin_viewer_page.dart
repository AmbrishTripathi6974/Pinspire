// pin_viewer_page.dart
// Full-screen pin viewer with Pinterest-style UI
// Matches the design from the reference image

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/core/utils/hero_tag_manager.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/pin/presentation/providers/pin_detail_provider.dart';
import 'package:pinterest/features/pin/presentation/widgets/pin_detail_bottom_section.dart';
import 'package:pinterest/features/pin/presentation/widgets/related_pins_grid.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';

/// Full-screen pin viewer page with Pinterest-style UI
class PinViewerPage extends ConsumerStatefulWidget {
  const PinViewerPage({
    super.key,
    required this.pinId,
    this.sourceHeroTag,
  });

  final String pinId;
  final String? sourceHeroTag;

  @override
  ConsumerState<PinViewerPage> createState() => _PinViewerPageState();
}

class _PinViewerPageState extends ConsumerState<PinViewerPage> {
  @override
  Widget build(BuildContext context) {
    final pinDetailState = ref.watch(pinDetailProvider(widget.pinId));
    final pin = pinDetailState.pin;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (pinDetailState.isLoading) {
      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: PinterestDotsLoader.centered(),
      );
    }

    if (pin == null) {
      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(LucideIcons.chevronLeft),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Text(
            pinDetailState.error ?? 'Pin not found',
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
        ),
      );
    }

    final screenHeight = MediaQuery.of(context).size.height;
    
    // Use source Hero tag if provided, otherwise generate fallback tag
    // This ensures Hero animation works correctly when navigating from feed
    final heroTag = widget.sourceHeroTag ?? 
        HeroTagManager.generateTag(
          pinId: pin.id,
          context: HeroTagContext.pinViewer,
        );

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Whole screen scrollable: image + header + related pins grid
            Positioned.fill(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  // Main pin image
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.6,
                      child: Hero(
                        tag: heroTag,
                        child: PinterestCachedImage(
                          imageUrl: pin.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: screenHeight * 0.6,
                          memCacheWidth: 800,
                          memCacheHeight: 1200,
                          placeholder: (_, __) => Container(
                            color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                            child: PinterestDotsLoader.centered(),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                            child: Icon(
                              LucideIcons.image,
                              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Actions, creator, "More to explore" title
                  SliverToBoxAdapter(
                    child: PinDetailBottomSectionHeader(pin: pin),
                  ),
                  // Related pins grid (same scroll)
                  SliverRelatedPinsGrid(
                    pins: pinDetailState.relatedPins,
                    isLoading: pinDetailState.isLoadingRelated,
                  ),
                ],
              ),
            ),

            // Top-left back button
            Positioned(
              top: 8,
              left: 8,
              child: _OverlayButton(
                icon: LucideIcons.chevronLeft,
                onTap: () => context.pop(),
                isDark: isDark,
              ),
            ),

            // Bottom-left "AI modified" tag (optional - can be based on pin data)
            // Positioned(
            //   bottom: MediaQuery.of(context).size.height * 0.4 + 8,
            //   left: 8,
            //   child: _AIModifiedTag(isDark: isDark),
            // ),
          ],
        ),
      ),
    );
  }
}

/// Semi-transparent overlay button (back button, search button)
class _OverlayButton extends StatelessWidget {
  const _OverlayButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black87,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

