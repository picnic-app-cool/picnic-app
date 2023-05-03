//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateChatSettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateChatSettingsFailure.unknown([this.cause]) : type = UpdateChatSettingsFailureType.unknown;

  final UpdateChatSettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateChatSettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateChatSettingsFailure{type: $type, cause: $cause}';
}

enum UpdateChatSettingsFailureType {
  unknown,
}
