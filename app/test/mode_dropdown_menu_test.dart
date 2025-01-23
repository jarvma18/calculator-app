import 'package:app/main.dart';
import 'package:app/src/components/mode_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ModeDropdownMenu widget tests', () {
    testWidgets('should set initial selection correctly', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeDropdownMenu(menuController: controller),
          ),
        ),
      );

      // Verify the initial selection is the first item
      expect(find.text(modeSelectionItems.first.label), findsOneWidget);
    });

    testWidgets('should update the selectedMode when selecting mode', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeDropdownMenu(menuController: controller),
          ),
        ),
      );

      // Tap to open dropdown menu using a specific Finder
      await tester.tap(find.byWidgetPredicate((widget) =>
          widget is Text && widget.data == modeSelectionItems.first.label));
      await tester.pumpAndSettle();

      // Select the second mode using a specific Finder
      await tester.tap(find.byWidgetPredicate((widget) =>
          widget is Text && widget.data == modeSelectionItems[1].label).last);
      await tester.pumpAndSettle();

      // Verify the selected mode is updated
      expect(find.text(modeSelectionItems[1].label), findsOneWidget);
    });

    testWidgets('should update controller correctly when selecting a mode', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeDropdownMenu(menuController: controller),
          ),
        ),
      );

      // Tap to open dropdown menu
      await tester.tap(find.text(modeSelectionItems.first.label));
      await tester.pumpAndSettle();

      // Select the second mode
      await tester.tap(find.text(modeSelectionItems[1].label).last);
      await tester.pumpAndSettle();

      // Verify the controller text is updated
      expect(controller.text, modeSelectionItems[1].label);
    });
  });
}
