import 'dart:math';

import 'package:app/src/components/calculator_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  Widget createWidgetForTest() {
    return MaterialApp(
      home: Scaffold(
        body: CalculatorKeyboard(
          onChanged: (String value, [TextSelection? selection]) {
            controller.value = TextEditingValue(text: value, selection: selection ?? TextSelection.collapsed(offset: value.length));
          },
        ),
      ),
    );
  }

  setUp(() {
    controller = TextEditingController();
  });

  tearDown(() {
    controller.dispose();
  });

  group('CalculatorKeyboard widget tests', () {
    testWidgets('should append value to calculator when a button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      final buttonFinder = find.text('1');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(controller.text, '1');
    });

    testWidgets('should remove last value from calculator when backspace is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      // Seed widget state by tapping digits.
      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('C'));
      await tester.pumpAndSettle();
      expect(controller.text, '12');
    });

    testWidgets('should clear all values from calculator when clear button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      // Seed widget state by tapping digits.
      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();
      await tester.longPress(find.text('C'));
      await tester.pumpAndSettle();
      expect(controller.text, '');
    });
});
}