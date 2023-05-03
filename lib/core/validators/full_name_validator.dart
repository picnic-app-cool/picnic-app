import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/validator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class FullNameValidator implements Validator<String, FullNameValidationError> {
  @override
  Either<FullNameValidationError, Unit> validate(String input) {
    if (input.isEmpty) {
      return failure(const FullNameValidationError.isEmpty());
    }
    return success(unit);
  }
}

class FullNameValidationError extends ValidationError {
  const FullNameValidationError(this.type);

  const FullNameValidationError.isEmpty() : type = FullNameValidationErrorType.isEmpty;

  final FullNameValidationErrorType type;
}

enum FullNameValidationErrorType {
  isEmpty,
}

extension FullNameValidationErrorExtension on FullNameValidationError {
  String get errorText {
    switch (type) {
      case FullNameValidationErrorType.isEmpty:
        return appLocalizations.fullNameEmptyErrorMessage;
    }
  }
}
