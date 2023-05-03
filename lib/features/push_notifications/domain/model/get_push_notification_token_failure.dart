import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPushNotificationTokenFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPushNotificationTokenFailure.unknown([this.cause]) : type = GetPushNotificationTokenFailureType.unknown;

  final GetPushNotificationTokenFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPushNotificationTokenFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPushNotificationTokenFailure{type: $type, cause: $cause}';
}

enum GetPushNotificationTokenFailureType {
  unknown,
}
