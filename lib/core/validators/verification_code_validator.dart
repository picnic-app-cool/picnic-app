import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/exact_length_validator.dart';
import 'package:picnic_app/core/validators/validator.dart';

class VerificationCodeValidator implements Validator<String, ValidationError> {
  const VerificationCodeValidator({
    required this.exactLengthValidator,
  });

  static const codeLength = 6;
  final ExactLengthValidator exactLengthValidator;

  @override
  Either<ValidationError, Unit> validate(String input) {
    final sanitizedInput = input //
        .trim();

    final validationErrors = [
      exactLengthValidator.validate(sanitizedInput),
    ] //
        .map((e) => e.getFailure())
        .whereNotNull();

    return validationErrors.isEmpty ? success(unit) : failure(validationErrors.first);
  }
}
