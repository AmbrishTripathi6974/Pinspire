// create_board_page.dart
// Create board modal/page

import 'package:flutter/material.dart';

/// Create board page.
class CreateBoardPage extends StatelessWidget {
  const CreateBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Board'),
      ),
      body: const Center(
        child: Text('Create a new board'),
      ),
    );
  }
}
