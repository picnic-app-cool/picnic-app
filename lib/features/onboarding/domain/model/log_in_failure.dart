import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class LogInFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LogInFailure.unknown([this.cause, this.userId]) : type = LogInFailureType.unknown;

  const LogInFailure.invalidCode([this.cause, this.userId]) : type = LogInFailureType.invalidCode;

  const LogInFailure.accountExistsWithDifferentCredential([this.cause, this.userId])
      : type = LogInFailureType.accountExistsWithDifferentCredential;

  const LogInFailure.invalidCredential([this.cause, this.userId]) : type = LogInFailureType.invalidCredential;

  const LogInFailure.operationNotAllowed([this.cause, this.userId]) : type = LogInFailureType.operationNotAllowed;

  const LogInFailure.userDisabled([this.cause, this.userId]) : type = LogInFailureType.userDisabled;

  const LogInFailure.userNotFound([this.cause, this.userId]) : type = LogInFailureType.userNotFound;

  const LogInFailure.wrongPassword([this.cause, this.userId]) : type = LogInFailureType.wrongPassword;

  const LogInFailure.invalidVerificationCode([this.cause, this.userId])
      : type = LogInFailureType.invalidVerificationCode;

  const LogInFailure.invalidVerificationId([this.cause, this.userId]) : type = LogInFailureType.invalidVerificationId;

  const LogInFailure.getUserDataFailure([this.cause, this.userId]) : type = LogInFailureType.getUserDataFailure;

  const LogInFailure.canceled([this.cause, this.userId]) : type = LogInFailureType.canceled;

  final LogInFailureType type;
  final Object? cause;
  final Id? userId;

  @override
  //ignore: long-method
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LogInFailureType.unknown:
      case LogInFailureType.invalidCode:
      case LogInFailureType.operationNotAllowed:
      case LogInFailureType.invalidVerificationId:
      case LogInFailureType.canceled:
      case LogInFailureType.getUserDataFailure:
        return DisplayableFailure.commonError();
      case LogInFailureType.accountExistsWithDifferentCredential:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.accountExistsWithDifferentCredentialErrorMessage,
        );
      case LogInFailureType.wrongPassword:
      case LogInFailureType.invalidCredential:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.invalidCredentialErrorMessage,
        );
      case LogInFailureType.userDisabled:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.userDisabledErrorMessage,
        );
      case LogInFailureType.userNotFound:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.userNotFoundErrorMessage,
        );

      case LogInFailureType.invalidVerificationCode:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.invalidVerificationCodeErrorMessage,
        );
    }
  }

  @override
  String toString() => 'LogInFailure{type: $type, cause: $cause}';

  AuthResult toAuthResult() => const AuthResult.empty().copyWith(userId: userId);
}

enum LogInFailureType {
  unknown,
  invalidCode,
  accountExistsWithDifferentCredential,
  invalidCredential,
  operationNotAllowed,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidVerificationCode,
  invalidVerificationId,
  getUserDataFailure,
  canceled,
}
