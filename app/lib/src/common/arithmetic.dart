mixin Arithmetic {

  List<String> listInputCharacters(String input) {
    return input.split('');
  }

  bool hasNonAllowedCharacters(List<String> input) {
    const allowedCharacters = '0123456789+-x÷().√²pi ';
    for (var char in input) {
      if (!allowedCharacters.contains(char)) {
        return true;
      }
    }
    return false;
  }

  bool hasMultipleOperatorsInRow(List<String> input) {
    const operators = '+-x÷';
    for (int i = 0; i < input.length - 1; i++) {
      if (operators.contains(input[i]) && operators.contains(input[i + 1])) {
        return true;
      }
    }
    return false;
  }

  bool hasMultipleArithmeticOperators(List<String> input) {
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

  bool hasOperatorAtStartOrEnd(List<String> input) {
    const operators = '+-x÷';
    if (input.isEmpty) return false;
    return operators.contains(input.first) || operators.contains(input.last);
  }

  bool hasMultipleDecimalPointsPerContinuousNumber(List<String> input) {
    int decimalPointCount = 0;
    for (var char in input) {
      if (char == '.') {
        decimalPointCount++;
        if (decimalPointCount > 1) {
          return true; 
        }
      } else if ('0123456789'.contains(char)) {
        continue; // part of the same number
      } else {
        decimalPointCount = 0; // reset for new number 
      }
    }
    return false;
  }

    bool isValidFormula(List<String> input) {
    if (hasNonAllowedCharacters(input)) {
      return false;
    }
    if (hasMultipleOperatorsInRow(input)) {
      return false;
    }
    if (hasOperatorAtStartOrEnd(input)) {
      return false;
    }
    if (hasMultipleDecimalPointsPerContinuousNumber(input)) {
      return false;
    }
    return true;
  }

  List<String> mergeNumbers(List<String> input) {
    List<String> merged = [];
    String currentNumber = '';
    for (var char in input) {
      if ('0123456789.'.contains(char)) {
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

  String buildFormulaWithResult(String formula, String result) {
    return '$formula = $result';
  }

  double _sum(double a, double b) => a + b;
  double _subtract(double a, double b) => a - b;
  double _multiply(double a, double b) => a * b;
  double _divide(double a, double b) => a / b;

  double calculateBasedOnOperator(double firstValue, String operator, double secondValue) {
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

  bool hasMoreThanThreeElements(List<String> input) {
    return input.length > 3;
  }

  String buildFormula(String firstValue, String operator, String secondValue) {
    //add spaces between values and operator for better readability
    return '$firstValue $operator $secondValue';
  }
}

class FunctionHoldingClassForMixin with Arithmetic {} // Used to access mixin methods in tests