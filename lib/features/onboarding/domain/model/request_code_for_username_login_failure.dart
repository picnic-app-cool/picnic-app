import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RequestCodeForUsernameLoginFailure implements HasDisplayableFailure {
  const RequestCodeForUsernameLoginFailure.unknown([this.cause])
      // ignore: avoid_field_initializers_in_const_classes
      : type = RequestCodeForUsernameLoginFailureType.unknown;

  final RequestCodeForUsernameLoginFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RequestCodeForUsernameLoginFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RequestCodeForUsernameLoginFailure{type: $type, cause: $cause}';
}

enum RequestCodeForUsernameLoginFailureType {
  unknown,
}
