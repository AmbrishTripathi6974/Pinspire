// Inbox update options bottom sheet - Pinterest-style
// Hide this update, Report

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:pinterest/features/inbox/domain/entities/inbox_update.dart';

/// Pinterest-style bottom sheet for update options in Inbox.
/// Options: Hide this update, Report.
class InboxUpdateOptionsBottomSheet extends StatelessWidget {
  const InboxUpdateOptionsBottomSheet({
    super.key,
    required this.update,
    this.onHide,
    this.onReport,
  });

  final InboxUpdate update;
  final VoidCallback? onHide;
  final VoidCallback? onReport;

  /// Show the bottom sheet.
  static Future<void> show({
    required BuildContext context,
    required InboxUpdate update,
    VoidCallback? onHide,
    VoidCallback? onReport,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => InboxUpdateOptionsBottomSheet(
        update: update,
        onHide: onHide,
        onReport: onReport,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // Options
            _OptionItem(
              icon: LucideIcons.eyeOff,
              label: 'Hide this update',
              onTap: () {
                Navigator.of(context).pop();
                onHide?.call();
              },
              textColor: textColor,
            ),
            _OptionItem(
              icon: LucideIcons.flag,
              label: 'Report',
              subtitle: "This goes against Pinterest's Community Guidelines",
              onTap: () {
                Navigator.of(context).pop();
                onReport?.call();
              },
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: textColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: GoogleFonts.poppins(
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
