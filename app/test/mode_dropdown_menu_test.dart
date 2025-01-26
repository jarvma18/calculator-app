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

    testWidgets('should update the selectedMode when selecting mode', (WidgetTester tester) async {
      
    });

    testWidgets('should update controller correctly when selecting a mode', (WidgetTester tester) async {
      
    });
  });
}