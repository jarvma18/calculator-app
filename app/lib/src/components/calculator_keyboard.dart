import 'dart:math';

import 'package:flutter/material.dart';

class KeyboardInput {
  String text;
  TextSelection selection;

  KeyboardInput(this.text, this.selection);
}

class CalculatorKeyboard extends StatefulWidget {
  const CalculatorKeyboard({
    super.key,
    required this.onChanged,
  });

  final void Function(String text, TextSelection selection) onChanged;

  @override
  State<CalculatorKeyboard> createState() => _CalculatorKeyboardState();
}

class _CalculatorKeyboardState extends State<CalculatorKeyboard> {
  KeyboardInput calculator = KeyboardInput('', TextSelection.collapsed(offset: 0));

  void _appendValueToCalculator(String value) {
    setState(() {
      calculator.text += value;
      calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _removeValueFromCalculator() {
    setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = text.substring(0, text.length - 1);
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _removeAllFromCalculator() {
    setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = '';
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  bool _containsOnlyAllowedCharacters(String input) {
    const validChars = '0123456789+-x÷(),√²';
    for (final char in input.split('')) {
      if (!validChars.contains(char)) {
        return false;
      }
    }
    return true;
  }

  List<String> _listInputCharacters(String input) {
    return input.split('');
  }

  bool _isFormulaValid(List<String> inputChars) {
    // No 2 operators in a row
    const operators = '+-x÷√²';
    for (int i = 0; i < inputChars.length - 1; i++) {
      if (operators.contains(inputChars[i]) && operators.contains(inputChars[i + 1])) {
        return false;
      }
    }
    // No two , in a number sequence
    bool inNumber = false;
    for (final char in inputChars) {
      if (char == ',') {
        if (inNumber) {
          return false;
        } else {
          inNumber = true;
        }
      } else if (!'0123456789'.contains(char)) {
        inNumber = false;
      }
    }
    return true;
  }

  void _calculateResult() {
    setState(() {
      if (calculator.text.isEmpty) {
        return;
      } else if (!_containsOnlyAllowedCharacters(calculator.text)) {
        calculator.text = 'Error';
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
        widget.onChanged(calculator.text, calculator.selection);
        print('Error: Invalid characters in input');
        return;
      } else {
        final inputChars = _listInputCharacters(calculator.text);
        print('Input Characters: $inputChars');
        calculator.text = 'Result'; // Replace with actual result
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  Widget _buildKeyboardButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: (350 / 5) - 4,
      height: (350 / 5) - 4,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFF7E7FF),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildClearButton({required String text, required VoidCallback onPressed, required VoidCallback onLongPress}) {
    return SizedBox(
      width: (350 / 5) - 4,
      height: (350 / 5) - 4,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFF7E7FF),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildResultButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: (350 - (3 * 4)) / 5 * 2,
      width: (350 / 5) - 4,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFF7E7FF),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildKeyboardColumn({required List<Widget> children,}) {
    return Column(
      spacing: 4,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 350,
      child: Row(
        spacing: 4,
        children: [
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: 'mod', onPressed: () {},),
            _buildKeyboardButton(text: '1', onPressed: () { _appendValueToCalculator('1'); },),
            _buildKeyboardButton(text: '4', onPressed: () { _appendValueToCalculator('4'); },),
            _buildKeyboardButton(text: '7', onPressed: () { _appendValueToCalculator('7'); },),
            _buildKeyboardButton(text: '(', onPressed: () { _appendValueToCalculator('('); },),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: '%', onPressed: () {},),
            _buildKeyboardButton(text: '2', onPressed: () { _appendValueToCalculator('2'); },),
            _buildKeyboardButton(text: '5', onPressed: () { _appendValueToCalculator('5'); },),
            _buildKeyboardButton(text: '8', onPressed: () { _appendValueToCalculator('8'); },),
            _buildKeyboardButton(text: '0', onPressed: () { _appendValueToCalculator('0'); },),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: ',', onPressed: () { _appendValueToCalculator(','); },),
            _buildKeyboardButton(text: '3', onPressed: () { _appendValueToCalculator('3'); },),
            _buildKeyboardButton(text: '6', onPressed: () { _appendValueToCalculator('6'); },),
            _buildKeyboardButton(text: '9', onPressed: () { _appendValueToCalculator('9'); },),
            _buildKeyboardButton(text: ')', onPressed: () { _appendValueToCalculator(')'); },),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: '÷', onPressed: () { _appendValueToCalculator('÷'); },),
            _buildKeyboardButton(text: 'x', onPressed: () { _appendValueToCalculator('x'); },),
            _buildKeyboardButton(text: '-', onPressed: () { _appendValueToCalculator('-'); },),
            _buildKeyboardButton(text: '+', onPressed: () { _appendValueToCalculator('+'); },),
            _buildClearButton(text: 'C', onPressed: () { _removeValueFromCalculator(); }, onLongPress: () { _removeAllFromCalculator(); }),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: 'pi', onPressed: () {},),
            _buildKeyboardButton(text: '√', onPressed: () { _appendValueToCalculator('√'); },),
            _buildKeyboardButton(text: '²', onPressed: () { _appendValueToCalculator('²'); },),
            _buildResultButton(text: '=', onPressed: () { _calculateResult(); },),
          ]),
        ],
      )
    );
  }
}
