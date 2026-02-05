// create_pin_page.dart
// Create pin page UI
// Pin creation form with image picker and board selection

import 'package:flutter/material.dart';

/// Create pin page.
class CreatePinPage extends StatelessWidget {
  const CreatePinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: const Center(
        child: Text('Create a pin'),
      ),
    );
  }
}
