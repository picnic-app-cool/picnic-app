// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUnreadNotificationsCountFailure implements HasDisplayableFailure {
  const GetUnreadNotificationsCountFailure.unknown([this.cause])
      : type = GetUnreadNotificationsCountFailureType.unknown;

  final GetUnreadNotificationsCountFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUnreadNotificationsCountFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUnreadNotificationsCountFailure{type: $type, cause: $cause}';
}

enum GetUnreadNotificationsCountFailureType {
  unknown,
}
