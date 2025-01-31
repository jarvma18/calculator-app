import 'package:app/src/components/calculation_bar.dart';
import 'package:app/src/components/calculation_history.dart';
import 'package:app/src/components/mode_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class ModeSelectionItem {
  final int id;
  final String label;

  ModeSelectionItem(this.id, this.label);
}

List<ModeSelectionItem> modeSelectionItems = [
  ModeSelectionItem(1, 'Basic'),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Calculator App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 21, 145)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // todo
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController menuController = TextEditingController();
  late TextEditingController calculatorController = TextEditingController();
  List<String> historyItems = <String>[
    '1 + 1 = 2', '2 + 3 = 5', ' 1 x 1 = 1', '2 + 3 = 5', '2 + 3 = 5',
    '2 + 3 = 5', '2 + 3 = 5', '2 + 3 = 5', '2 + 3 = 5', ' 1 x 1 = 1',
    ' 1 x 1 = 1', ' 1 x 1 = 1', ' 1 x 1 = 1', ' 1 x 1 = 1'
  ];
  void _appendValue(String value) {
    setState(() {
      calculatorController.text += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  ModeDropdownMenu(menuController: menuController),
                  CalculationHistory(historyItems: historyItems),
                  CalculationBar(calculatorController: calculatorController),
                  SizedBox(
                    height: 250,
                    width: 300,
                    child: Row(
                      children: [
                        // First column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () {}, child: Text('mod')),
                            TextButton(onPressed: () {}, child: Text('1')),
                            TextButton(onPressed: () {}, child: Text('4')),
                            TextButton(onPressed: () {}, child: Text('7')),
                            TextButton(onPressed: () {}, child: Text('(')),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Second column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () {}, child: Text('%')),
                            TextButton(onPressed: () {}, child: Text('2')),
                            TextButton(onPressed: () {}, child: Text('5')),
                            TextButton(onPressed: () {}, child: Text('8')),
                            TextButton(onPressed: () {}, child: Text('0')),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Third column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () {}, child: Text(',')),
                            TextButton(onPressed: () {}, child: Text('3')),
                            TextButton(onPressed: () {}, child: Text('6')),
                            TextButton(onPressed: () {}, child: Text('9')),
                            TextButton(onPressed: () {}, child: Text(')')),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Fourth column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () {}, child: Text('÷')),
                            TextButton(onPressed: () {}, child: Text('x')),
                            TextButton(onPressed: () {}, child: Text('-')),
                            TextButton(onPressed: () {}, child: Text('+')),
                            TextButton(onPressed: () {}, child: Text('C')),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Fifth column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () {}, child: Text('pi')),
                            TextButton(onPressed: () {}, child: Text('√')),
                            TextButton(onPressed: () {}, child: Text('x²')),
                            SizedBox(
                              height: (250 - (10 * 4)) / 5 * 2 + 10, // height of 2 rows plus spacing
                              child: TextButton(
                                onPressed: () {},
                                child: Text('='),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  )
                ],
              )
            )
          )
        );
      }
    );
  }
}
