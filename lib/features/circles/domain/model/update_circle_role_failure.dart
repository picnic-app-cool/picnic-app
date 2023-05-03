import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateCircleRoleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateCircleRoleFailure.unknown([this.cause]) : type = UpdateCircleRoleFailureType.unknown;

  final UpdateCircleRoleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateCircleRoleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateCircleRoleFailure{type: $type, cause: $cause}';
}

enum UpdateCircleRoleFailureType {
  unknown,
}
