import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnAssignUserRoleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnAssignUserRoleFailure.unknown([this.cause]) : type = UnAssignUserRoleFailureType.unknown;

  final UnAssignUserRoleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnAssignUserRoleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnAssignUserRoleFailure{type: $type, cause: $cause}';
}

enum UnAssignUserRoleFailureType {
  unknown,
}
