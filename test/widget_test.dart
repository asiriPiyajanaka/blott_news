import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blott_news/app.dart';

void main() {
  group('App Widget Tests', () {
    testWidgets('App launches with MaterialApp.router',
        (WidgetTester tester) async {
      // Build the app and trigger a frame
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Verify that the app contains MaterialApp.router
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Scaffold is present in the app', (WidgetTester tester) async {
      // Build the app and trigger a frame
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Verify that a Scaffold widget exists
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('App title is correctly set', (WidgetTester tester) async {
      // Build the app and trigger a frame
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Check if the app title is correctly set (optional check)
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, equals('Blott News'));
    });
  });
}
