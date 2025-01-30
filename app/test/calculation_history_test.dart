import 'package:app/src/components/calculation_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<String> historyItems = <String>[
    '1 + 1 = 2', '2 + 2 = 4', '3 + 3 = 6'
  ];

  Widget createWidgetForTest() {
    return MaterialApp(
      home: Scaffold(
        body: CalculationHistory(historyItems: historyItems),
      ),
    );
  }

  group('CalculationHistory widget tests', () {
    testWidgets('should find all history items as a text', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());

      expect(find.text('1 + 1 = 2'), findsOneWidget);
      expect(find.text('2 + 2 = 4'), findsOneWidget);
      expect(find.text('3 + 3 = 6'), findsOneWidget);
    });

    testWidgets('should have given order when using reverse mode', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTest());
      final itemWidgets = tester.widgetList(find.byType(Center)).toList();

      expect((itemWidgets[0] as Center).child, isInstanceOf<Text>());
      expect(((itemWidgets[0] as Center).child as Text).data, '1 + 1 = 2');
      expect((itemWidgets[1] as Center).child, isInstanceOf<Text>());
      expect(((itemWidgets[1] as Center).child as Text).data, '2 + 2 = 4');
      expect((itemWidgets[2] as Center).child, isInstanceOf<Text>());
      expect(((itemWidgets[2] as Center).child as Text).data, '3 + 3 = 6');
    });
  });
}