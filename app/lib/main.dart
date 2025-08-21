import 'package:app/src/components/calculator_bar.dart';
import 'package:app/src/components/calculator_history.dart';
import 'package:app/src/components/calculator_keyboard.dart';
import 'package:app/src/components/calculator_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          // ···
          brightness: Brightness.dark,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ), 
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController menu = TextEditingController();
  late TextEditingController calculator = TextEditingController();
  List<String> historyItems = <String>[];

  void _appendKeyboardStateToCalculator(String value, [TextSelection? selection]) {
    final selValue = selection ?? TextSelection.collapsed(offset: value.length);
    calculator.value = TextEditingValue(text: value, selection: selValue);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            backgroundColor: const Color(0xFF232427),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  CalculatorMode(menuController: menu),
                  CalculatorHistory(historyItems: historyItems),
                  CalculatorBar(calculatorController: calculator),
                  const SizedBox(height: 4),
                  CalculatorKeyboard(onChanged: _appendKeyboardStateToCalculator),
                ],
              )
            )
          )
        );
      }
    );
  }
}
