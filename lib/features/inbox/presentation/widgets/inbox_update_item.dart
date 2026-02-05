// Single update row for Inbox Updates list
// Thumbnail, title, time, unread dot, more options - Pinterest style

import 'package:flutter/material.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// One update row: [unread dot] thumbnail | title + time | three dots
class InboxUpdateItem extends StatelessWidget {
  const InboxUpdateItem({
    super.key,
    required this.title,
    required this.timeAgo,
    required this.imageUrl,
    this.isUnread = true,
    this.onTap,
    this.onMoreTap,
  });

  final String title;
  final String timeAgo;
  final String imageUrl;
  final bool isUnread;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black;
    final timeColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final iconColor = isDark ? Colors.white70 : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Unread indicator (red dot)
              if (isUnread) ...[
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE60023),
                    shape: BoxShape.circle,
                  ),
                ),
              ] else
                const SizedBox(width: 20),
              // Thumbnail - rounded rectangle
              SizedBox(
                width: 56,
                height: 56,
                child: PinterestCachedImage(
                  imageUrl: imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(8),
                  placeholder: (_, __) => Container(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: const Center(
                      child: PinterestDotsLoader.compact(),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: Icon(LucideIcons.image, color: iconColor, size: 24),
                  ),
                  memCacheWidth: 112,
                  memCacheHeight: 112,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      timeAgo,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: timeColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onMoreTap,
                icon: Icon(LucideIcons.moreHorizontal, size: 20, color: iconColor),
                style: IconButton.styleFrom(
                  minimumSize: const Size(40, 40),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
