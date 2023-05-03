import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RequestRuntimePermissionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RequestRuntimePermissionFailure.unknown([this.cause]) : type = RequestRuntimePermissionFailureType.unknown;

  final RequestRuntimePermissionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RequestRuntimePermissionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RequestRuntimePermissionFailure{type: $type, cause: $cause}';
}

enum RequestRuntimePermissionFailureType {
  unknown,
}
