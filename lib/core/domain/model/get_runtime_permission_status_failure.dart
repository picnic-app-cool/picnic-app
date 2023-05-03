import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRuntimePermissionStatusFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetRuntimePermissionStatusFailure.unknown([this.cause]) : type = GetRuntimePermissionStatusFailureType.unknown;

  final GetRuntimePermissionStatusFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRuntimePermissionStatusFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRuntimePermissionStatusFailure{type: $type, cause: $cause}';
}

enum GetRuntimePermissionStatusFailureType {
  unknown,
}
