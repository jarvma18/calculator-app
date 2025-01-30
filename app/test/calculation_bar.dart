import 'package:app/src/components/calculation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  Widget createWidgetForTest() {
    return MaterialApp(
      home: Scaffold(
        body: CalculationBar(calculatorController: controller),
      ),
    );
  }

  setUp(() {
    controller = TextEditingController();
  });

  group('CalculationBar widget tests', () {
    testWidgets('...', (WidgetTester tester) async {

    });
  });
}