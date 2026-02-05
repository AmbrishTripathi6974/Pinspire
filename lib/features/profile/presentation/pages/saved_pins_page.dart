// saved_pins_page.dart
// Saved pins full page (used when navigating to saved route)

import 'package:flutter/material.dart';
import 'package:pinterest/features/profile/presentation/widgets/saved_pins_tab.dart';

/// Full-page view of saved pins.
class SavedPinsPage extends StatelessWidget {
  const SavedPinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Pins'),
      ),
      body: const SavedPinsTab(),
    );
  }
}
