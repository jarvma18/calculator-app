import 'package:app/src/components/calculation_bar.dart';
import 'package:app/src/components/calculation_history.dart';
import 'package:app/src/components/calculation_mode.dart';
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
  final TextEditingController menu = TextEditingController();
  late TextEditingController calculator = TextEditingController();
  List<String> historyItems = <String>[
    '1 + 1 = 2', '2 + 3 = 5', ' 1 x 1 = 1', '2 + 3 = 5', '2 + 3 = 5',
    '2 + 3 = 5', '2 + 3 = 5', '2 + 3 = 5', '2 + 3 = 5', ' 1 x 1 = 1',
    ' 1 x 1 = 1', ' 1 x 1 = 1', ' 1 x 1 = 1', ' 1 x 1 = 1'
  ];
  void _appendValueToCalculator(String value) {
    setState(() {
      calculator.text += value;
    });
  }

  void _removeValueFromCalculator() {
    setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = text.substring(0, text.length - 1);
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
  }

  void _removeAllFromCalculator() {
    setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = '';
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
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
                  CalculationMode(menuController: menu),
                  CalculationHistory(historyItems: historyItems),
                  CalculationBar(calculatorController: calculator),
                  CalculationKeyboard()
                ],
              )
            )
          )
        );
      }
    );
  }
}

class CalculationKeyboard extends StatelessWidget {
  const CalculationKeyboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 300,
      child: Row(
        children: [
          // First column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // children: [
            //   TextButton(onPressed: () {}, child: Text('mod')), // Action
            //   TextButton(onPressed: () { _appendValueToCalculator('1'); }, child: Text('1')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('4'); }, child: Text('4')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('7'); }, child: Text('7')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('('); }, child: Text('(')), // Append text
            // ],
          ),
          SizedBox(height: 10),
          // Second column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // children: [
            //   TextButton(onPressed: () {}, child: Text('%')), // Action
            //   TextButton(onPressed: () { _appendValueToCalculator('2'); }, child: Text('2')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('5'); }, child: Text('5')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('8'); }, child: Text('8')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('0'); }, child: Text('0')), // Append text
            // ],
          ),
          SizedBox(height: 10),
          // Third column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // children: [
            //   TextButton(onPressed: () { _appendValueToCalculator(','); }, child: Text(',')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('3'); }, child: Text('3')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('6'); }, child: Text('6')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('9'); }, child: Text('9')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator(')'); }, child: Text(')')), // Append text
            // ],
          ),
          SizedBox(height: 10),
          // Fourth column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            //   TextButton(onPressed: () { _appendValueToCalculator('÷'); }, child: Text('÷')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('x'); }, child: Text('x')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('-'); }, child: Text('-')), // Append text
            //   TextButton(onPressed: () { _appendValueToCalculator('+'); }, child: Text('+')), // Append text
            //   TextButton(
            //     onPressed: () { _removeValueFromCalculator(); },
            //     onLongPress: () { _removeAllFromCalculator(); },
            //     child: Text('C')), // Remove text
            // ],
          ),
          SizedBox(height: 10),
          // Fifth column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TextButton(onPressed: () {}, child: Text('pi')), //Action
              // TextButton(onPressed: () { _appendValueToCalculator('√'); }, child: Text('√')), // Append text
              // TextButton(onPressed: () { _appendValueToCalculator('²'); }, child: Text('x²')), // Append text
              // SizedBox(
              //   height: (250 - (10 * 4)) / 5 * 2 + 10, // height of 2 rows plus spacing
              //   child: TextButton(
              //     onPressed: () {},
              //     child: Text('='), // Action
              //   ),
              // ),
            ],
          )
        ],
      )
    );
  }
}
