// board_detail_page.dart
// Board detail page UI
// Shows all pins in a specific board

import 'package:flutter/material.dart';

/// Board detail page showing pins in the board.
class BoardDetailPage extends StatelessWidget {
  const BoardDetailPage({super.key, required this.boardId});

  final String boardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
      ),
      body: Center(
        child: Text('Board: $boardId'),
      ),
    );
  }
}
