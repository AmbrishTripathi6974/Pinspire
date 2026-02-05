// boards_page.dart
// Boards list page UI
// Displays user's boards in grid layout

import 'package:flutter/material.dart';

/// Boards list page.
class BoardsPage extends StatelessWidget {
  const BoardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boards'),
      ),
      body: const Center(
        child: Text('Your boards'),
      ),
    );
  }
}
