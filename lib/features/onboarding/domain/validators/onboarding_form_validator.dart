import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/validator.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class OnboardingFormValidator implements Validator<OnboardingFormData, OnboardingValidationError> {
  @override
  Either<OnboardingValidationError, Unit> validate(OnboardingFormData input) {
    if (!input.authResult.authenticated) {
      return failure(OnboardingValidationError.notAuthenticated);
    } else if (input.username.isEmpty) {
      return failure(OnboardingValidationError.missingUsername);
    }
    return success(unit);
  }
}

enum OnboardingValidationError {
  notAuthenticated,
  missingUsername;

  String get title {
    switch (this) {
      case OnboardingValidationError.notAuthenticated:
      case OnboardingValidationError.missingUsername:
        return appLocalizations.commonErrorTitle;
    }
  }

  String get message {
    switch (this) {
      case OnboardingValidationError.notAuthenticated:
        return appLocalizations.notAuthenticatedErrorMessage;
      case OnboardingValidationError.missingUsername:
        return appLocalizations.missingUsernameErrorMessage;
    }
  }
}
