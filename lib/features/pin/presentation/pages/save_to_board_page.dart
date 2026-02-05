// save_to_board_page.dart
// Save pin to board modal/page

import 'package:flutter/material.dart';

/// Save to board page for selecting a board to save a pin to.
class SaveToBoardPage extends StatelessWidget {
  const SaveToBoardPage({super.key, required this.pinId});

  final String pinId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save to Board'),
      ),
      body: Center(
        child: Text('Save pin $pinId to a board'),
      ),
    );
  }
}
