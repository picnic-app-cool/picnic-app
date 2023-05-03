import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserRolesInCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserRolesInCircleFailure.unknown([this.cause]) : type = GetUserRolesInCircleFailureType.unknown;

  final GetUserRolesInCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserRolesInCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleRolesFailure{type: $type, cause: $cause}';
}

enum GetUserRolesInCircleFailureType {
  unknown,
}
