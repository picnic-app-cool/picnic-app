import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RequestPhoneCodeFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RequestPhoneCodeFailure.unknown([this.cause]) : type = RequestPhoneCodeFailureType.unknown;

  final RequestPhoneCodeFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RequestPhoneCodeFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RequestPhoneCodeFailure{type: $type, cause: $cause}';
}

enum RequestPhoneCodeFailureType {
  unknown,
}
