import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateDeviceTokenFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateDeviceTokenFailure.unknown([this.cause]) : type = UpdateDeviceTokenFailureType.unknown;

  const UpdateDeviceTokenFailure.unauthenticated([this.cause]) : type = UpdateDeviceTokenFailureType.unauthenticated;

  const UpdateDeviceTokenFailure.emptyToken([this.cause]) : type = UpdateDeviceTokenFailureType.emptyToken;

  final UpdateDeviceTokenFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateDeviceTokenFailureType.unknown:
      case UpdateDeviceTokenFailureType.unauthenticated:
      case UpdateDeviceTokenFailureType.emptyToken:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateDeviceTokenFailure{type: $type, cause: $cause}';
}

enum UpdateDeviceTokenFailureType {
  unknown,
  unauthenticated,
  emptyToken,
}
