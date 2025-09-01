import 'package:flutter/material.dart';
import '../common/arithmetic.dart';

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

class _CalculatorKeyboardState extends State<CalculatorKeyboard> with Arithmetic {
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

  void _setErrorState() {
    setState(() {
      calculator.text = 'Error';
      calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _setNotSupportedState() {
    setState(() {
      calculator.text = 'Not Supported';
      calculator.selection = TextSelection.collapsed(offset: calculator.text.length);
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _hasZeroDivisionError(double secondValue, String operator) {
    String divideOperator = '÷';
    if (operator == divideOperator && secondValue == 0) {
      _setErrorState();
      throw Exception('Division by zero');
    }
  }

  void _hasUnsupportedOperator(String operator) {
    const supportedOperators = '+-x÷';
    if (!supportedOperators.contains(operator)) {
      _setNotSupportedState();
      throw Exception('Unsupported operator');
    }
  }

  void _setResult(String result) {
    setState(() {
      calculator.text = result;
      calculator.selection = TextSelection.collapsed(offset: result.length);
    });
    widget.onChanged(calculator.text, calculator.selection);
  }

  void _calculateResult(List<String> input) {
    double firstValue = double.parse(input[0]);
    String operator = input[1];
    double secondValue = double.parse(input[2]);
    _hasUnsupportedOperator(operator);
    _hasZeroDivisionError(secondValue, operator);
    String formula = buildFormula(firstValue.toString(), operator, secondValue.toString());
    double result = calculateBasedOnOperator(firstValue, operator, secondValue);
    String formulaWithResult = buildFormulaWithResult(formula, result.toString());
    _setResult(formulaWithResult);
    _setResult(result.toString());
  }

  void _equalTo() {
    setState(() {
      if (calculator.text.isEmpty) {
        return;
      }
      List<String> input = listInputCharacters(calculator.text);
      List<String> mergedInput = mergeNumbers(input);
      if (!isValidFormula(input)) {
        _setErrorState();
        return;
      }
      if (hasMultipleArithmeticOperators(input)) {
        _setNotSupportedState();
        return;
      }
      if (hasMoreThanThreeElements(mergedInput)) {
        _setNotSupportedState();
        return;
    }
      _calculateResult(mergedInput);
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
            _buildKeyboardButton(text: '.', onPressed: () { _appendValue('.'); },),
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
            _buildKeyboardButton(text: 'π', onPressed: () { _appendValue('π'); },),
            _buildKeyboardButton(text: '√', onPressed: () { _appendValue('√'); },),
            _buildKeyboardButton(text: '²', onPressed: () { _appendValue('²'); },),
            _buildResultButton(text: '=', onPressed: () { _equalTo(); },),
          ]),
        ],
      )
    );
  }
}
