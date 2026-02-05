// pin_detail_bottom_section.dart
// Bottom section of pin detail page with actions, creator info, and related pins

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_options_bottom_sheet.dart';
import 'package:pinterest/features/home/presentation/widgets/save_to_nav_animation_overlay.dart';
import 'package:pinterest/features/pin/presentation/widgets/related_pins_grid.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

void _showPinOptions(BuildContext context, WidgetRef ref, Pin pin) {
  PinOptionsBottomSheet.show(
    context: context,
    pin: pin,
    inspirationText: 'This Pin is inspired by your viewing.',
    onSave: () {
      final isCurrentlySaved = ref.read(savedPinsProvider).isPinSaved(pin.id);
      if (!isCurrentlySaved && context.mounted) {
        SaveToNavAnimationOverlay.show(
          context: context,
          imageUrl: pin.imageUrl,
          startPosition: null,
        );
      }
      ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
    },
    onShare: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Share functionality coming soon')),
      );
    },
    onSeeMoreLikeThis: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("We'll show you more pins like this")),
      );
    },
    onSeeLessLikeThis: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("We'll show you fewer pins like this")),
      );
    },
    onReport: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted. Thank you!')),
      );
    },
  );
}

/// Header only: actions, creator, "More to explore" title. Used with [SliverRelatedPinsGrid] for whole-screen scroll.
class PinDetailBottomSectionHeader extends ConsumerWidget {
  const PinDetailBottomSectionHeader({super.key, required this.pin});

  final Pin pin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSaved = ref.watch(isPinSavedProvider(pin.id));
    final isLiked = ref.watch(isPinLikedProvider(pin.id));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _ActionIconButton(
                  icon: LucideIcons.heart,
                  isActive: isLiked,
                  isFilled: isLiked,
                  onTap: () => ref.read(savedPinsProvider.notifier).toggleLikePin(pin.id),
                  isDark: isDark,
                ),
                const SizedBox(width: 4),
                _ActionIconButton(
                  icon: LucideIcons.messageCircle,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Comments coming soon')),
                    );
                  },
                  isDark: isDark,
                ),
                const SizedBox(width: 4),
                _ActionIconButton(
                  icon: LucideIcons.share2,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share functionality coming soon')),
                    );
                  },
                  isDark: isDark,
                ),
                const SizedBox(width: 4),
                _ActionIconButton(
                  icon: LucideIcons.moreHorizontal,
                  onTap: () => _showPinOptions(context, ref, pin),
                  isDark: isDark,
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () {
                    if (!isSaved && context.mounted) {
                      SaveToNavAnimationOverlay.show(
                        context: context,
                        imageUrl: pin.imageUrl,
                        startPosition: null,
                      );
                    }
                    ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE60023),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    minimumSize: const Size(0, 44),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isSaved ? 'Saved' : 'Save',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE60023),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'ID',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pin.photographer,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'More to explore',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

/// Bottom section with actions, creator info, and related pins (legacy: grid in a fixed-height box).
class PinDetailBottomSection extends ConsumerWidget {
  const PinDetailBottomSection({
    super.key,
    required this.pin,
    required this.relatedPins,
    this.isLoadingRelated = false,
  });

  final Pin pin;
  final List<Pin> relatedPins;
  final bool isLoadingRelated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PinDetailBottomSectionHeader(pin: pin),
          RelatedPinsGrid(
            pins: relatedPins,
            isLoading: isLoadingRelated,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Action icon button (heart, comment, share, more)
class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
    this.isActive = false,
    this.isFilled = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final bool isActive;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isActive
              ? const Color(0xFFE60023)
              : (isDark ? Colors.white : Colors.black87),
          size: 22,
          fill: isFilled ? 1.0 : 0.0,
        ),
      ),
    );
  }
}
