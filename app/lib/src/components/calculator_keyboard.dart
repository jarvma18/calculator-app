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

  List<String> _listInputCharacters(String input) {
    return input.split('');
  }

  bool _hasNonAllowedCharacters(List<String> input) {
    const allowedCharacters = '0123456789+-x÷(),√²pi ';
    for (var char in input) {
      if (!allowedCharacters.contains(char)) {
        return true;
      }
    }
    return false;
  }

  bool _hasMultipleOperatorsInRow(List<String> input) {
    const operators = '+-x÷';
    for (int i = 0; i < input.length - 1; i++) {
      if (operators.contains(input[i]) && operators.contains(input[i + 1])) {
        return true;
      }
    }
    return false;
  }

  bool _hasMultipleArithmeticOperators(List<String> input) {
    const operators = '+-x÷';
    int count = 0;
    for (var char in input) {
      if (operators.contains(char)) {
        count++;
      }
      if (count > 1) {
        return true;
      }
    }
    return false;
  }

  bool _hasOperatorAtStartOrEnd(List<String> input) {
    const operators = '+-x÷';
    if (input.isEmpty) return false;
    return operators.contains(input.first) || operators.contains(input.last);
  }

  bool _hasMultipleDecimalPoints(List<String> input) {
    int decimalPointCount = 0;
    for (var char in input) {
      if (char == ',') {
        decimalPointCount++;
      }
      if (decimalPointCount > 1) {
        return true;
      }
    }
    return false;
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

  bool _isValidFormula(List<String> input) {
    if (_hasNonAllowedCharacters(input)) {
      return false;
    }
    if (_hasMultipleOperatorsInRow(input)) {
      return false;
    }
    if (_hasOperatorAtStartOrEnd(input)) {
      return false;
    }
    if (_hasMultipleDecimalPoints(input)) {
      return false;
    }
    return true;
  }

  List<String> _mergeNumbers(List<String> input) {
    List<String> merged = [];
    String currentNumber = '';
    for (var char in input) {
      if ('0123456789,'.contains(char)) {
        currentNumber += char;
      } else {
        if (currentNumber.isNotEmpty) {
          merged.add(currentNumber);
          currentNumber = '';
        }
        merged.add(char);
      }
    }
    if (currentNumber.isNotEmpty) {
      merged.add(currentNumber);
    }
    return merged;
  }

  void _calculateResult(List<String> input) {
    double firstValue = double.parse(input[0]);
    String operator = input[1];
    double secondValue = double.parse(input[2]);
    double result = 0;
    switch (operator) {
      case '+':
        result = firstValue + secondValue;
        break;
      case '-':
        result = firstValue - secondValue;
        break;
      case 'x':
        result = firstValue * secondValue;
        break;
      case '÷':
        if (secondValue == 0) {
          _setErrorState();
          return;
        }
        result = firstValue / secondValue;
        break;
      default:
        _setNotSupportedState();
        return;
    }
  }

  String _buildFormulaWithResult(String formula, String result) {
    return '$formula = $result';
  }

  double _sum(double a, double b) => a + b;
  double _subtract(double a, double b) => a - b;
  double _multiply(double a, double b) => a * b;
  double _divide(double a, double b) => a / b;

  double _calculateBasedOnOperator(double firstValue, String operator, double secondValue) {
    String sumOperator = '+';
    String subtractOperator = '-';
    String multiplyOperator = 'x';
    String divideOperator = '÷';

    if (operator == sumOperator) {
      return _sum(firstValue, secondValue);
    } else if (operator == subtractOperator) {
      return _subtract(firstValue, secondValue);
    } else if (operator == multiplyOperator) {
      return _multiply(firstValue, secondValue);
    } else if (operator == divideOperator) {
      return _divide(firstValue, secondValue);
    } else {
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

  void _calculate() {
    setState(() {
      if (calculator.text.isEmpty) {
        return;
      }
      List<String> input = _listInputCharacters(calculator.text);
      if (!_isValidFormula(input)) {
        _setErrorState();
        return;
      }
      if (_hasMultipleArithmeticOperators(input)) {
        _setNotSupportedState();
        return;
      }
      if (_hasMoreThanThreeElements(input)) {
      _setNotSupportedState();
      return;
    }
      _calculateResult(_mergeNumbers(input));
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
