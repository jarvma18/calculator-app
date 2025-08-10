import 'package:flutter/material.dart';

class KeyboardInput {
  String text;
  TextSelection selection;

  KeyboardInput(this.text, this.selection);
}

class CalculationKeyboard extends StatefulWidget {
  const CalculationKeyboard({
    super.key,
    required this.keyboardController
  });

  final TextEditingController keyboardController;

  @override
  State<CalculationKeyboard> createState() => _CalculationKeyboardState();
}

class _CalculationKeyboardState extends State<CalculationKeyboard> {
  KeyboardInput calculator = KeyboardInput('', TextSelection.collapsed(offset: 0));

  void _appendValueToCalculator(String value) {
    return setState(() {
      calculator.text += value;
    });
  }

  void _removeValueFromCalculator() {
    return setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = text.substring(0, text.length - 1);
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
  }

  void _removeAllFromCalculator() {
    return setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = '';
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
  }

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
            children: [
              TextButton(onPressed: () {}, child: Text('mod')), // Action
              TextButton(onPressed: () { _appendValueToCalculator('1'); }, child: Text('1')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('4'); }, child: Text('4')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('7'); }, child: Text('7')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('('); }, child: Text('(')), // Append text
            ],
          ),
          // Second column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: Text('%')), // Action
              TextButton(onPressed: () { _appendValueToCalculator('2'); }, child: Text('2')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('5'); }, child: Text('5')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('8'); }, child: Text('8')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('0'); }, child: Text('0')), // Append text
            ],
          ),
          // Third column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () { _appendValueToCalculator(','); }, child: Text(',')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('3'); }, child: Text('3')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('6'); }, child: Text('6')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('9'); }, child: Text('9')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator(')'); }, child: Text(')')), // Append text
            ],
          ),
          // Fourth column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () { _appendValueToCalculator('÷'); }, child: Text('÷')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('x'); }, child: Text('x')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('-'); }, child: Text('-')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('+'); }, child: Text('+')), // Append text
              TextButton(
                onPressed: () { _removeValueFromCalculator(); },
                onLongPress: () { _removeAllFromCalculator(); },
                child: Text('C')), // Remove text
            ],
          ),
          // Fifth column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: Text('pi')), //Action
              TextButton(onPressed: () { _appendValueToCalculator('√'); }, child: Text('√')), // Append text
              TextButton(onPressed: () { _appendValueToCalculator('²'); }, child: Text('x²')), // Append text
              SizedBox(
                height: (250 - (10 * 4)) / 5 * 2 + 10, // height of 2 rows plus spacing
                child: TextButton(
                  onPressed: () {},
                  child: Text('='), // Action
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
