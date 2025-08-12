import 'package:app/src/components/calcular_bar.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 21, 145)),
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
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  CalculatorMode(menuController: menu),
                  CalculatorHistory(historyItems: historyItems),
                  CalculatorBar(calculatorController: calculator),
                  CalculationKeyboard(onChanged: _appendKeyboardStateToCalculator),
                ],
              )
            )
          )
        );
      }
    );
  }
}
