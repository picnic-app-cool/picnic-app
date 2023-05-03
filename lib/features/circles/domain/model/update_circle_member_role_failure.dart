import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateCircleMemberRoleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateCircleMemberRoleFailure.unknown([this.cause]) : type = UpdateCircleMemberRoleFailureType.unknown;

  final UpdateCircleMemberRoleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateCircleMemberRoleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateCircleMemberRoleFailure{type: $type, cause: $cause}';
}

enum UpdateCircleMemberRoleFailureType {
  unknown,
}
