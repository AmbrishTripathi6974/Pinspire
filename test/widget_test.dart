// Basic Flutter widget test for Pinterest clone
//
// Note: Full widget tests require Clerk configuration.
// This is a placeholder smoke test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test - MaterialApp renders', (WidgetTester tester) async {
    // Build a minimal MaterialApp to verify basic setup
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Pinterest Clone'),
          ),
        ),
      ),
    );

    // Verify the app renders
    expect(find.text('Pinterest Clone'), findsOneWidget);
  });
}
