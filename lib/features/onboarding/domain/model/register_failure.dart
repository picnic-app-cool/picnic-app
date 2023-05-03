import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/onboarding/domain/validators/onboarding_form_validator.dart';

class RegisterFailure implements HasDisplayableFailure {
  const RegisterFailure.unknown([this.cause]) : type = RegisterFailureType.unknown;

  const RegisterFailure.validationError([this.cause]) : type = RegisterFailureType.validationError;

  const RegisterFailure.userNotAuthenticated([this.cause]) : type = RegisterFailureType.userNotAuthenticated;

  final RegisterFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RegisterFailureType.unknown:
      case RegisterFailureType.userNotAuthenticated:
        return DisplayableFailure.commonError();
      case RegisterFailureType.validationError:
        final err = cause as OnboardingValidationError?;
        return err == null //
            ? DisplayableFailure.commonError()
            : DisplayableFailure(title: err.title, message: err.message);
    }
  }

  @override
  String toString() => 'RegisterFailure{type: $type, cause: $cause}';
}

enum RegisterFailureType {
  unknown,
  validationError,
  userNotAuthenticated,
}
