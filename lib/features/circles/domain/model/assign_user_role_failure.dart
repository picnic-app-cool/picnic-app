import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class AssignUserRoleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AssignUserRoleFailure.unknown([this.cause]) : type = AssignUserRoleFailureType.unknown;

  final AssignUserRoleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AssignUserRoleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AssignUserRoleFailure{type: $type, cause: $cause}';
}

enum AssignUserRoleFailureType {
  unknown,
}
