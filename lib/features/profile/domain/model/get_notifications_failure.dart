import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetNotificationsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetNotificationsFailure.unknown([this.cause]) : type = GetNotificationsFailureType.unknown;

  final GetNotificationsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetNotificationsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetNotificationsFailure{type: $type, cause: $cause}';
}

enum GetNotificationsFailureType {
  unknown,
}
