import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RecaptchaVerificationFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RecaptchaVerificationFailure.unknown([this.cause]) : type = RecaptchaVerificationFailureType.unknown;

  final RecaptchaVerificationFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RecaptchaVerificationFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RecaptchaVerificationFailure{type: $type, cause: $cause}';
}

enum RecaptchaVerificationFailureType {
  unknown,
}
