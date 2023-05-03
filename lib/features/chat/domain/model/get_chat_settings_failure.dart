//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetChatSettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatSettingsFailure.unknown([this.cause]) : type = GetChatSettingsFailureType.unknown;

  final GetChatSettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatSettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatSettingsFailure{type: $type, cause: $cause}';
}

enum GetChatSettingsFailureType {
  unknown,
}
