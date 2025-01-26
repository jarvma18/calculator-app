import 'package:app/main.dart';
import 'package:app/src/components/mode_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  Widget createWidgetForTest() {
    return MaterialApp(
      home: Scaffold(
        body: ModeDropdownMenu(menuController: controller),
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

      // Open the dropdown by tapping on the initial selection
      await tester.tap(find.byType(DropdownMenu<ModeSelectionItem>));
      await tester.pumpAndSettle();

      // Select the second mode by tapping on its label
      await tester.tap(find.text('Basic').last);  // Ensure we're selecting the second item
      await tester.pumpAndSettle();

      // Verify the selected mode is updated
      expect(find.text('Basic').last, findsOneWidget);
      expect(controller.text, 'Basic');
    });

    testWidgets('should update controller correctly when selecting a mode', (WidgetTester tester) async {
      
    });
  });
}