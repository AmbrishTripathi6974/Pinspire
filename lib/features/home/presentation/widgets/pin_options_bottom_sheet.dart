// Pin options bottom sheet widget
// Pinterest-style bottom sheet for pin actions (home feed more options)

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';

/// Pinterest-style bottom sheet shown when tapping more (⋯) on a pin in the home feed.
///
/// Layout: handle bar, close (X), optional "sent by" chip, mascot, inspiration text,
/// then Save, Share, See more/less like this, Report Pin.
class PinOptionsBottomSheet extends StatelessWidget {
  const PinOptionsBottomSheet({
    super.key,
    required this.pin,
    this.onSave,
    this.onShare,
    this.onSeeMoreLikeThis,
    this.onSeeLessLikeThis,
    this.onReport,
    this.inspirationText,
    this.sentByLabel,
  });

  final Pin pin;
  final VoidCallback? onSave;
  final VoidCallback? onShare;
  final VoidCallback? onSeeMoreLikeThis;
  final VoidCallback? onSeeLessLikeThis;
  final VoidCallback? onReport;
  final String? inspirationText;
  /// Optional label e.g. "the person who sent u this" shown above the mascot.
  final String? sentByLabel;

  /// Show the bottom sheet
  static Future<void> show({
    required BuildContext context,
    required Pin pin,
    VoidCallback? onSave,
    VoidCallback? onShare,
    VoidCallback? onSeeMoreLikeThis,
    VoidCallback? onSeeLessLikeThis,
    VoidCallback? onReport,
    String? inspirationText,
    String? sentByLabel,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PinOptionsBottomSheet(
        pin: pin,
        onSave: onSave,
        onShare: onShare,
        onSeeMoreLikeThis: onSeeMoreLikeThis,
        onSeeLessLikeThis: onSeeLessLikeThis,
        onReport: onReport,
        inspirationText: inspirationText,
        sentByLabel: sentByLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    // Pin preview: 60% above sheet, 40% inside
    const double pinPreviewHeight = _PinImagePreview.previewHeight;
    const double pinPreviewInside = pinPreviewHeight * 0.3; // 40% inside
    const double pinPreviewOutside = pinPreviewHeight * 0.7; // 60% above

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Sheet body (sizes to content — no minimum height, no bottom gap)
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Close (X) top-left
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        LucideIcons.x,
                        size: 24,
                        color: textColor,
                      ),
                    ),
                  ),
                ),

                // Space for overlapping pin image (40% inside sheet)
                SizedBox(height: pinPreviewInside),

                // Centered block: optional "sent by" chip, mascot, inspiration text (no gap above)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Column(
                    children: [
                      if (sentByLabel != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            sentByLabel!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: textColor.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (inspirationText != null) ...[
                        Text(
                          inspirationText!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

                // Options list
                _OptionItem(
                  icon: LucideIcons.pin,
                  label: pin.saved ? 'Saved' : 'Save',
                  onTap: () {
                    Navigator.of(context).pop();
                    onSave?.call();
                  },
                  textColor: textColor,
                ),
                _OptionItem(
                  icon: LucideIcons.share2,
                  label: 'Share',
                  onTap: () {
                    Navigator.of(context).pop();
                    onShare?.call();
                  },
                  textColor: textColor,
                ),
                _OptionItem(
                  icon: LucideIcons.heart,
                  label: 'See more like this',
                  onTap: () {
                    Navigator.of(context).pop();
                    onSeeMoreLikeThis?.call();
                  },
                  textColor: textColor,
                ),
                _OptionItem(
                  icon: LucideIcons.eyeOff,
                  label: 'See less like this',
                  onTap: () {
                    Navigator.of(context).pop();
                    onSeeLessLikeThis?.call();
                  },
                  textColor: textColor,
                ),
                _OptionItem(
                  icon: LucideIcons.ban,
                  label: 'Report Pin',
                  subtitle: "This goes against Pinterest's Community Guidelines",
                  onTap: () {
                    Navigator.of(context).pop();
                    onReport?.call();
                  },
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        // Pin image: 60% above sheet, 40% inside
        Positioned(
          top: -pinPreviewOutside,
          left: 0,
          right: 0,
          child: Center(
            child: _PinImagePreview(pin: pin),
          ),
        ),
      ],
    );
  }
}

/// Thumbnail of the pin image so the user sees which pin they're saving/acting on.
class _PinImagePreview extends StatelessWidget {
  const _PinImagePreview({required this.pin});

  final Pin pin;

  static const double _maxWidth = 120;
  static const double previewHeight = 200;
  static const double _borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final width = (pin.aspectRatio * previewHeight).clamp(60.0, _maxWidth);

    return SizedBox(
      width: width,
      height: previewHeight,
      child: PinterestCachedImage(
        imageUrl: pin.imageUrl,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(_borderRadius),
        memCacheWidth: 280,
        memCacheHeight: (280 / pin.aspectRatio).round(),
        placeholder: (_, __) => Container(
          color: surfaceColor,
          child: const Center(
            child: PinterestDotsLoader.compact(),
          ),
        ),
        errorWidget: (_, __, ___) => Container(
          color: surfaceColor,
          child: Icon(
            LucideIcons.image,
            color: theme.colorScheme.onSurfaceVariant,
            size: 28,
          ),
        ),
      ),
    );
  }
}

/// Individual option item in the bottom sheet
class _OptionItem extends StatelessWidget {
  const _OptionItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.textColor,
    this.subtitle,
    this.subtitleColor,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Color textColor;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: textColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: subtitleColor ?? Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
