import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/validator.dart';

class ExactLengthValidator implements Validator<String, ExactLengthValidationError> {
  const ExactLengthValidator({
    required this.length,
  });

  final int length;

  @override
  Either<ExactLengthValidationError, Unit> validate(String input) {
    final sanitizedInput = input //
        .trim();
    return sanitizedInput.length != length ? failure(ExactLengthValidationError()) : success(unit);
  }
}

class ExactLengthValidationError extends ValidationError {}
