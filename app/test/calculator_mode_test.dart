import 'package:app/src/components/calculator_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;
  List<ModeSelectionItem> modeSelectionItems = [
    ModeSelectionItem(1, 'Basic'),
  ];

  Widget createWidgetForTest() {
    return MaterialApp(
      home: Scaffold(
        body: CalculatorMode(menuController: controller),
      ),
    );
  }

  setUp(() {
    controller = TextEditingController();
  });

  group('ModeDropdownMenu widget tests', () {
    testWidgets('should set initial selection correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      final initialSelection = modeSelectionItems.first.label;

      expect(find.text(initialSelection).last, findsOneWidget);
    });

    testWidgets('should update the selected mode to Basic when selecting Basic mode', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      await tester.tap(find.byType(DropdownMenu<ModeSelectionItem>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Basic').last);
      await tester.pumpAndSettle();

      expect(find.text('Basic').last, findsOneWidget);
      expect(controller.text, 'Basic');
    });
  });
}