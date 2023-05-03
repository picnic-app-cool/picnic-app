import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/validator.dart';

class PhoneValidator implements Validator<String, ValidationError> {
  @override
  Either<ValidationError, Unit> validate(String input) {
    final sanitizedInput = input //
        .trim()
        .replaceAll(RegExp(r'[\s-()]'), '');
    return RegExp(r"^[+]?[0-9]{8,17}$").hasMatch(sanitizedInput) ? success(unit) : failure(const ValidationError());
  }
}
