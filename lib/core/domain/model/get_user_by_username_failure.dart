import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserByUsernameFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserByUsernameFailure.unknown([this.cause]) : type = GetUserByUsernameFailureType.unknown;

  final GetUserByUsernameFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserByUsernameFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserByUsernameFailure{type: $type, cause: $cause}';
}

enum GetUserByUsernameFailureType {
  unknown,
}
