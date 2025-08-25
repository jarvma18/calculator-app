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

  void _appendValue(String value) {
    setState(() {
      calculator.text += value;
      calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _removeSingleValue() {
    setState(() {
      String text = calculator.text;
      if (text.isNotEmpty) {
        calculator.text = text.substring(0, text.length - 1);
        calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
      }
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _removeAll() {
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

  bool _areOperatorsInRow(List<String> input) {
    const operators = '+-x÷√²';
    for (int i = 0; i < input.length - 1; i++) {
      if (operators.contains(input[i]) && operators.contains(input[i + 1])) {
        return true;
      }
    }
    return false;
  }

  bool _multipleCommasInNumber(List<String> input) {
    bool inNumber = false;
    for (final char in input) {
      if (char == ',') {
        if (inNumber) {
          return true;
        } else {
          inNumber = true;
        }
      } else if (!'0123456789'.contains(char)) {
        inNumber = false;
      }
    }
    return false;
  }

  bool _isValidFormula(List<String> input) {
    // No 2 operators in a row
    const operators = '+-x÷√²';
    for (int i = 0; i < input.length - 1; i++) {
      if (operators.contains(input[i]) && operators.contains(input[i + 1])) {
        return false;
      }
    }
    // No two , in a number sequence
    bool inNumber = false;
    for (final char in input) {
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
            _buildKeyboardButton(text: '1', onPressed: () { _appendValue('1'); },),
            _buildKeyboardButton(text: '4', onPressed: () { _appendValue('4'); },),
            _buildKeyboardButton(text: '7', onPressed: () { _appendValue('7'); },),
            _buildKeyboardButton(text: '(', onPressed: () { _appendValue('('); },),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: '%', onPressed: () {},),
            _buildKeyboardButton(text: '2', onPressed: () { _appendValue('2'); },),
            _buildKeyboardButton(text: '5', onPressed: () { _appendValue('5'); },),
            _buildKeyboardButton(text: '8', onPressed: () { _appendValue('8'); },),
            _buildKeyboardButton(text: '0', onPressed: () { _appendValue('0'); },),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: ',', onPressed: () { _appendValue(','); },),
            _buildKeyboardButton(text: '3', onPressed: () { _appendValue('3'); },),
            _buildKeyboardButton(text: '6', onPressed: () { _appendValue('6'); },),
            _buildKeyboardButton(text: '9', onPressed: () { _appendValue('9'); },),
            _buildKeyboardButton(text: ')', onPressed: () { _appendValue(')'); },),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: '÷', onPressed: () { _appendValue('÷'); },),
            _buildKeyboardButton(text: 'x', onPressed: () { _appendValue('x'); },),
            _buildKeyboardButton(text: '-', onPressed: () { _appendValue('-'); },),
            _buildKeyboardButton(text: '+', onPressed: () { _appendValue('+'); },),
            _buildClearButton(text: 'C', onPressed: () { _removeSingleValue(); }, onLongPress: () { _removeAll(); }),
          ]),
          _buildKeyboardColumn(children: [
            _buildKeyboardButton(text: 'pi', onPressed: () {},),
            _buildKeyboardButton(text: '√', onPressed: () { _appendValue('√'); },),
            _buildKeyboardButton(text: '²', onPressed: () { _appendValue('²'); },),
            _buildResultButton(text: '=', onPressed: () { _calculateResult(); },),
          ]),
        ],
      )
    );
  }
}
