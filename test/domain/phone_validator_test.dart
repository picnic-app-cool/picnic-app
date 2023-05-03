import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';

void main() {
  late PhoneValidator validator;

  test(
    'should match polish phone numbers',
    () {
      expect(validator.validate("+48721218344").isSuccess, isTrue);
      expect(validator.validate("+48 721 218 344").isSuccess, isTrue);
      expect(validator.validate("   +48 721 218   344     ").isSuccess, isTrue);
      expect(validator.validate("48 721218344").isSuccess, isTrue);
    },
  );

  test(
    'should match american phone numbers',
    () {
      expect(validator.validate("+14155552671").isSuccess, isTrue);
      expect(validator.validate("+1 415 555 2671").isSuccess, isTrue);
      expect(validator.validate("+1 (415) 555-2671").isSuccess, isTrue);
      expect(validator.validate("        +1 (415) 555-2671    ").isSuccess, isTrue);
    },
  );

  test(
    'should match german phone numbers',
    () {
      expect(validator.validate("+4915227654381").isSuccess, isTrue);
      expect(validator.validate("+49 152 276 54381").isSuccess, isTrue);
      expect(validator.validate("+49 (152) 27654381").isSuccess, isTrue);
      expect(validator.validate("        +4915227654381         ").isSuccess, isTrue);
    },
  );

  test(
    'should not match invalid phone numbers',
    () {
      expect(validator.validate("+1415571").isFailure, isTrue);
      expect(validator.validate("").isFailure, isTrue);
      expect(validator.validate("+").isFailure, isTrue);
      expect(validator.validate("abc").isFailure, isTrue);
      expect(validator.validate("12abc112").isFailure, isTrue);
      expect(validator.validate("+141555526712381223").isFailure, isTrue);
    },
  );

  setUp(() => validator = PhoneValidator());
}
