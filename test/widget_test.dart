// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_expiry_tracker/main.dart';

void main() {
  testWidgets('App loads and shows available items tab',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify app title is shown
    expect(find.text('Available Items'), findsOneWidget);

    // Verify bottom navigation items are present
    expect(find.text('Available'), findsOneWidget);
    expect(find.text('Consumed'), findsOneWidget);
    expect(find.text('Expired'), findsOneWidget);

    // Verify navigation icons are present
    expect(find.byIcon(Icons.food_bank), findsOneWidget);
    expect(find.byIcon(Icons.history), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber), findsOneWidget);
  });

  testWidgets('Navigation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to Consumed tab
    await tester.tap(find.text('Consumed'));
    await tester.pumpAndSettle();
    expect(find.text('Consumed Items'), findsOneWidget);

    // Navigate to Expired tab
    await tester.tap(find.text('Expired'));
    await tester.pumpAndSettle();
    expect(find.text('Expired Items'), findsOneWidget);
  });
}
