//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class AddUserToChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AddUserToChatFailure.unknown([this.cause]) : type = AddUserToChatFailureType.unknown;

  final AddUserToChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AddUserToChatFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AddUserToChatFailure{type: $type, cause: $cause}';
}

enum AddUserToChatFailureType {
  unknown,
}
