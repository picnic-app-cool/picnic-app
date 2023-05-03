import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetNotificationSettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetNotificationSettingsFailure.unknown([this.cause]) : type = GetNotificationSettingsFailureType.unknown;

  final GetNotificationSettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetNotificationSettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetNotificationSettingsFailure{type: $type, cause: $cause}';
}

enum GetNotificationSettingsFailureType {
  unknown,
}
