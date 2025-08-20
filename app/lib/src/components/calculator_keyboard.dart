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

  Widget _buildKeyboardButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildClearButton({required String text, required VoidCallback onPressed, required VoidCallback onLongPress}) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildResultButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: (250 - (10 * 4)) / 5 * 2 + 10, // height of 2 rows plus spacing
      width: 50,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildKeyboardColumn({required List<Widget> children,}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 350,
      child: Row(
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
            _buildResultButton(text: '=', onPressed: () {}),
          ]),
        ],
      )
    );
  }
}
