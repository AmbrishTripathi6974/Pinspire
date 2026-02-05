// saved_pins_tab.dart
// Pins tab: filter pills, Board suggestions, Your saved Pins masonry grid

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/home/presentation/widgets/masonry_grid.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_quick_action_overlay.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

class SavedPinsTab extends ConsumerWidget {
  const SavedPinsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final savedPins = ref.watch(savedPinsListProvider);
    final onSave = ref.read(savedPinsProvider.notifier).toggleSavePin;

    return CustomScrollView(
      slivers: [
        // Your saved Pins section (filter row is fixed in header)
        if (savedPins.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'No saved pins yet',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          SliverMasonryPinGrid(
            pins: savedPins,
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.all(8),
            showOptionsButton: false,
            onPinTap: (pin) {},
            onSavePin: (pin) => onSave(pin),
            actionContext: PinQuickActionContext.savedPins,
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

