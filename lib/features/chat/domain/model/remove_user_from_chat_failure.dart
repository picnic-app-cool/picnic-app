//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RemoveUserFromChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RemoveUserFromChatFailure.unknown([this.cause]) : type = RemoveUserFromChatFailureType.unknown;

  final RemoveUserFromChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RemoveUserFromChatFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RemoveUserFromChatFailure{type: $type, cause: $cause}';
}

enum RemoveUserFromChatFailureType {
  unknown,
}
