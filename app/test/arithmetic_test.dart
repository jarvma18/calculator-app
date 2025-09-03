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
}
