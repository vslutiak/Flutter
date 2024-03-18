// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_color/main.dart';

void main() {
  group('MyHomePage Tests', () {
    testWidgets('Test if widget is build without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(MyHomePage), findsOneWidget);
    });

    testWidgets('Test if background color changes onTap',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      final Finder myHomePageFinder = find.byType(MyHomePage);
      final MyHomePageState myHomePageState =
          tester.state<MyHomePageState>(myHomePageFinder);
      final initialColor = myHomePageState.backgroundColor;
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      final updatedColor = myHomePageState.backgroundColor;
      expect(initialColor, isNot(updatedColor));
    });
  });
}
