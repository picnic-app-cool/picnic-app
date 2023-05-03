import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/validator.dart';

class AgeValidator implements Validator<String, AgeValidationError> {
  static const minimumAge = 13;
  static const maximumAge = 99;

  @override
  Either<AgeValidationError, Unit> validate(String input) {
    final sanitizedInput = input.trim();
    if (sanitizedInput.startsWith('0')) {
      return failure(const AgeValidationError.invalidInput());
    }
    final intVal = int.tryParse(sanitizedInput);

    if (intVal == null) {
      return failure(const AgeValidationError.invalidInput());
    }
    if (intVal < minimumAge) {
      return failure(const AgeValidationError.tooYoung());
    }
    if (intVal > maximumAge) {
      return failure(const AgeValidationError.invalidInput());
    }
    return success(unit);
  }
}

class AgeValidationError extends ValidationError {
  const AgeValidationError(this.type);

  const AgeValidationError.tooYoung() : type = AgeValidationErrorType.tooYoung;

  const AgeValidationError.invalidInput() : type = AgeValidationErrorType.invalidInput;

  final AgeValidationErrorType type;
}

enum AgeValidationErrorType {
  tooYoung,
  invalidInput,
}
