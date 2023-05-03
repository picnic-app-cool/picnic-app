import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateNotificationSettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateNotificationSettingsFailure.unknown([this.cause]) : type = UpdateNotificationSettingsFailureType.unknown;

  final UpdateNotificationSettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateNotificationSettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateNotificationSettingsFailure{type: $type, cause: $cause}';
}

enum UpdateNotificationSettingsFailureType {
  unknown,
}
