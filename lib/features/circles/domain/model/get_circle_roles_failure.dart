import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleRolesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleRolesFailure.unknown([this.cause]) : type = GetCircleRolesFailureType.unknown;

  final GetCircleRolesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCircleRolesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleRolesFailure{type: $type, cause: $cause}';
}

enum GetCircleRolesFailureType {
  unknown,
}
