import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/validator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class UsernameValidator implements Validator<String, UsernameValidationError> {
  static const maxLength = 30;

  @override
  Either<UsernameValidationError, Unit> validate(String input) {
    //TODO: check for special chars but exclude emoji : https://picnic-app.atlassian.net/browse/GS-4415
    if (input.isEmpty) {
      return failure(const UsernameValidationError.isEmpty());
    }
    if (input.length > maxLength) {
      return failure(const UsernameValidationError.tooLong());
    }
    if (input.contains(' ')) {
      return failure(const UsernameValidationError.containsSpaces());
    }
    if (input != input.toLowerCase()) {
      return failure(const UsernameValidationError.isNotLowerCase());
    }
    return success(unit);
  }
}

class UsernameValidationError extends ValidationError {
  const UsernameValidationError(this.type);

  const UsernameValidationError.tooLong() : type = UsernameValidationErrorType.tooLong;

  const UsernameValidationError.containsSpaces() : type = UsernameValidationErrorType.containsSpaces;

  const UsernameValidationError.isNotLowerCase() : type = UsernameValidationErrorType.isNotLowerCase;

  const UsernameValidationError.isEmpty() : type = UsernameValidationErrorType.isEmpty;

  final UsernameValidationErrorType type;
}

enum UsernameValidationErrorType {
  tooLong,
  isNotLowerCase,
  isEmpty,
  containsSpaces,
}

extension UsernameValidationErrorExtension on UsernameValidationError {
  String get errorText {
    switch (type) {
      case UsernameValidationErrorType.tooLong:
        return appLocalizations.usernameTooLongErrorMessage;
      case UsernameValidationErrorType.isNotLowerCase:
        return appLocalizations.usernameNotLowerCaseErrorMessage;
      case UsernameValidationErrorType.containsSpaces:
        return appLocalizations.usernameContainsSpacesErrorMessage;
      case UsernameValidationErrorType.isEmpty:
        return appLocalizations.usernameEmptyErrorMessage;
    }
  }
}
