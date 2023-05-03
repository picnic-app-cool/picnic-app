//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class InviteUserToChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const InviteUserToChatFailure.unknown([this.cause]) : type = InviteUserToChatFailureType.unknown;

  final InviteUserToChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case InviteUserToChatFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'InviteUserToChatFailure{type: $type, cause: $cause}';
}

enum InviteUserToChatFailureType {
  unknown,
}
