import 'package:test/test.dart';
import 'package:app/src/common/arithmetic.dart';

void main() {
  late FunctionHoldingClassForMixin mockClass;
  setUp(() {
    mockClass = FunctionHoldingClassForMixin();
  });
  group('listInputCharacters', () {
    test('should split input string into list of characters', () {
      expect(mockClass.listInputCharacters('12+34'), ['1', '2', '+', '3', '4']);
    });

    test('should return empty list for empty input', () {
      expect(mockClass.listInputCharacters(''), []);
    });
  });

  group('hasNonAllowedCharacters', () {
    test('should return true if input contains non-allowed characters', () {
      expect(mockClass.hasNonAllowedCharacters(['1', '2', 'a', '3', '4']), true);
    });

    test('should return false if input contains only allowed characters', () {
      expect(mockClass.hasNonAllowedCharacters(['1', '2', '+', '3', '4']), false);
    });

    test('should return false for empty input', () {
      expect(mockClass.hasNonAllowedCharacters([]), false);
    });
  });

  group('hasMultipleOperatorsInRow', () {
    test('should return true if input has multiple operators in a row', () {
      expect(mockClass.hasMultipleOperatorsInRow(['1', '+', '-', '3', '4']), true);
    });

    test('should return false if input does not have multiple operators in a row', () {
      expect(mockClass.hasMultipleOperatorsInRow(['1', '+', '2', '3', '4']), false);
    });

    test('should return false for empty input', () {
      expect(mockClass.hasMultipleOperatorsInRow([]), false);
    });
  });

  group('hasMultipleArithmeticOperators', () {
    test('should return true if input has more than one arithmetic operator', () {
      expect(mockClass.hasMultipleArithmeticOperators(['1', '+', '2', 'x', '3']), true);
    });

    test('should return false if input has one or no arithmetic operators', () {
      expect(mockClass.hasMultipleArithmeticOperators(['1', '+', '2', '3']), false);
    });

    test('should return false for empty input', () {
      expect(mockClass.hasMultipleArithmeticOperators([]), false);
    });
  });

  group('hasOperatorAtStartOrEnd', () {
    test('should return true if input starts with an operator', () {
      expect(mockClass.hasOperatorAtStartOrEnd(['+', '1', '2', '3']), true);
    });

    test('should return true if input ends with an operator', () {
      expect(mockClass.hasOperatorAtStartOrEnd(['1', '2', '3', '-']), true);
    });

    test('should return false if input does not start or end with an operator', () {
      expect(mockClass.hasOperatorAtStartOrEnd(['1', '2', '3']), false);
    });

    test('should return false for empty input', () {
      expect(mockClass.hasOperatorAtStartOrEnd([]), false);
    });
  });

  group('hasMultipleDecimalPointsPerContinuousNumber', () {
    test('should return true if a continuous number has multiple decimal points', () {
      expect(mockClass.hasMultipleDecimalPointsPerContinuousNumber(['1', '.', '2', '.', '3']), true);
    });

    test('should return false if no continuous number has multiple decimal points', () {
      expect(mockClass.hasMultipleDecimalPointsPerContinuousNumber(['1', '.', '2', '+', '3', '.', '4']), false);
    });

    test('should return false for empty input', () {
      expect(mockClass.hasMultipleDecimalPointsPerContinuousNumber([]), false);
    });
  });

  group('isValidFormula', () {
    test('should return false if input has non-allowed characters', () {
      expect(mockClass.isValidFormula(['1', '2', 'a', '3', '4']), false);
    });

    test('should return false if input has multiple operators in a row', () {
      expect(mockClass.isValidFormula(['1', '+', '-', '3', '4']), false);
    });

    test('should return false if input starts or ends with an operator', () {
      expect(mockClass.isValidFormula(['+', '1', '2', '3']), false);
      expect(mockClass.isValidFormula(['1', '2', '3', '-']), false);
    });

    test('should return false if a continuous number has multiple decimal points', () {
      expect(mockClass.isValidFormula(['1', '.', '2', '.', '3']), false);
    });

    test('should return true for a valid formula', () {
      expect(mockClass.isValidFormula(['1', '+', '2', 'x', '3']), true);
    });

    test('should return true for empty input', () {
      expect(mockClass.isValidFormula([]), true);
    });
  });

  group('mergeNumbers', () {
    test('should merge consecutive number characters into single numbers', () {
      expect(mockClass.mergeNumbers(['1', '2', '+', '3', '4', '.', '5']), ['12', '+', '34.5']);
    });

    test('should handle input with no numbers', () {
      expect(mockClass.mergeNumbers(['+', '-', 'x']), ['+', '-', 'x']);
    });

    test('should handle empty input', () {
      expect(mockClass.mergeNumbers([]), []);
    });
  });

  group('buildFormulaWithResult', () {
    test('should append result to formula with equals sign', () {
      expect(mockClass.buildFormulaWithResult('12+34', '46'), '12+34 = 46');
    });
  });

  group('calculateBasedOnOperator', () {
    test('should perform addition', () {
      expect(mockClass.calculateBasedOnOperator(2, '+', 3), 5);
    });

    test('should perform subtraction', () {
      expect(mockClass.calculateBasedOnOperator(5, '-', 3), 2);
    });

    test('should perform multiplication', () {
      expect(mockClass.calculateBasedOnOperator(4, 'x', 3), 12);
    });

    test('should perform division', () {
      expect(mockClass.calculateBasedOnOperator(6, '÷', 3), 2);
    });

    test('should throw exception for unknown operator', () {
      expect(() => mockClass.calculateBasedOnOperator(6, '%', 3), throwsA(isA<Exception>()));
    });
  });

  group('hasMoreThanThreeElements', () {
    test('should return true if input has more than three elements', () {
      expect(mockClass.hasMoreThanThreeElements(['1', '+', '2', 'x', '3']), true);
    });

    test('should return false if input has three or fewer elements', () {
      expect(mockClass.hasMoreThanThreeElements(['1', '+', '2']), false);
      expect(mockClass.hasMoreThanThreeElements(['1', '+']), false);
      expect(mockClass.hasMoreThanThreeElements(['1']), false);
      expect(mockClass.hasMoreThanThreeElements([]), false);
    });
  });

  group('buildFormula', () {
    test('should build formula string from components', () {
      expect(mockClass.buildFormula('12', '+', '34'), '12 + 34');
    });
  });
}
