import 'package:app/src/components/calculator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  Widget createWidgetForTest() {
    return MaterialApp(
      home: Scaffold(
        body: CalculatorBar(calculatorController: controller),
      ),
    );
  }

  setUp(() {
    controller = TextEditingController();
  });

  group('CalculationBar widget tests', () {
    testWidgets('should be empty read-only text field when initialized', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      final textFieldFinder = find.byType(TextField);
      final TextField textField = tester.widget<TextField>(textFieldFinder);
      
      expect(find.text(''), findsOneWidget);
      expect(textField.readOnly, true);
    });
  });
}