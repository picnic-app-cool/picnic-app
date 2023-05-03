import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCaptchaParamsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCaptchaParamsFailure.unknown([this.cause]) : type = GetCaptchaParamsFailureType.unknown;

  final GetCaptchaParamsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCaptchaParamsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCaptchaParamsFailure{type: $type, cause: $cause}';
}

enum GetCaptchaParamsFailureType {
  unknown,
}
