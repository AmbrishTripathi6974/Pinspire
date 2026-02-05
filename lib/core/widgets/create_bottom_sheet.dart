// Pinterest-style "Create" bottom sheet - UI only
// Top bar: close icon + centered title; three options: Pin, Collage, Board

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Pinterest-style bottom sheet for "Start creating now".
/// UI-only: no tap handlers, no navigation, no business logic.
///
/// Content:
/// - Top bar: left close (X), centered title "Start creating now"
/// - Three options in a row: Pin, Collage, Board (icon container + label)
/// - Height wraps content; rounded top corners; white background.
class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

  /// Show the create bottom sheet. UI-only; caller may wire close/options later.
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const CreateBottomSheet(),
    );
  }

  static const double _sheetRadius = 22;
  static const double _iconContainerRadius = 16;
  static const double _iconContainerSize = 56;
  static const double _iconSize = 24;
  static const Color _iconContainerBg = Color(0xFFF0F0F0);
  static const Color _iconColor = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final iconContainerBg = isDark ? Colors.grey.shade800 : _iconContainerBg;
    final iconColor = isDark ? Colors.grey.shade200 : _iconColor;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(_sheetRadius)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TopBar(textColor: textColor),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                    child: _CreateOption(
                      icon: LucideIcons.pin,
                      label: 'Pin',
                      iconContainerBg: iconContainerBg,
                      iconColor: iconColor,
                      textColor: textColor,
                    ),
                  ),
                  Expanded(
                    child: _CreateOption(
                      icon: LucideIcons.layoutGrid,
                      label: 'Collage',
                      iconContainerBg: iconContainerBg,
                      iconColor: iconColor,
                      textColor: textColor,
                    ),
                  ),
                  Expanded(
                    child: _CreateOption(
                      icon: LucideIcons.layoutDashboard,
                      label: 'Board',
                      iconContainerBg: iconContainerBg,
                      iconColor: iconColor,
                      textColor: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

/// Top bar: left close (X), centered title "Start creating now". Close icon dismisses sheet.
class _TopBar extends StatelessWidget {
  const _TopBar({required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(LucideIcons.x, size: 24, color: textColor),
              style: IconButton.styleFrom(
                minimumSize: const Size(48, 48),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          Center(
            child: Text(
              'Start creating now',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Single create option: rounded icon container + label below.
class _CreateOption extends StatelessWidget {
  const _CreateOption({
    required this.icon,
    required this.label,
    required this.iconContainerBg,
    required this.iconColor,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color iconContainerBg;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: CreateBottomSheet._iconContainerSize,
          height: CreateBottomSheet._iconContainerSize,
          decoration: BoxDecoration(
            color: iconContainerBg,
            borderRadius: BorderRadius.circular(CreateBottomSheet._iconContainerRadius),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: CreateBottomSheet._iconSize,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
