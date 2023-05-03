import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/age_validator.dart';

void main() {
  late AgeValidator validator;

  test(
    'should match age between 13-99',
    () {
      expect(validator.validate("13").isSuccess, isTrue);
      expect(validator.validate("26").isSuccess, isTrue);
      expect(validator.validate("99").isSuccess, isTrue);
    },
  );

  test(
    'should not match age > 99 and < 13',
    () {
      expect(validator.validate("12").isFailure, isTrue);
      expect(validator.validate("10").isFailure, isTrue);
      expect(validator.validate("0").isFailure, isTrue);
    },
  );

  test(
    'should not match age starting with 0',
    () {
      expect(validator.validate("0").isFailure, isTrue);
      expect(validator.validate("01").isFailure, isTrue);
      expect(validator.validate("0010101001").isFailure, isTrue);
    },
  );

  setUp(() => validator = AgeValidator());
}
