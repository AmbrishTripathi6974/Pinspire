// saved_collages_tab.dart
// Collages tab: filter pills (Created by you | In progress), empty state

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SavedCollagesTab extends ConsumerWidget {
  const SavedCollagesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // Empty state (filter row is fixed in header)
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CollageIllustration(isDark: isDark),
                  const SizedBox(height: 24),
                  Text(
                    'Make your first collage',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Snip and paste the best parts of your favourite Pins to create something completely new.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Material(
                    color: const Color(0xFFE60023),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Create collage')),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: const Text(
                          'Create collage',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Placeholder illustration: circle with scissors icon (collage theme).
class _CollageIllustration extends StatelessWidget {
  const _CollageIllustration({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue.shade200,
      Colors.orange.shade200,
      Colors.red.shade200,
      Colors.purple.shade100,
      isDark ? Colors.grey.shade700 : Colors.grey.shade200,
    ];

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Abstract shapes (overlapping circles)
          ...List.generate(5, (i) {
            return Positioned(
              left: 20.0 + i * 25,
              top: 30.0 + (i % 2) * 20,
              child: Container(
                width: 80 + i * 10,
                height: 80 + i * 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors[i % colors.length].withOpacity(0.8),
                ),
              ),
            );
          }),
          const Icon(
            LucideIcons.scissors,
            size: 64,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
