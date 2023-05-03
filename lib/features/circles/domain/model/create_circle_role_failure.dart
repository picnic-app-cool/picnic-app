import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class CreateCircleRoleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateCircleRoleFailure.unknown([this.cause]) : type = CreateCircleRoleFailureType.unknown;

  final CreateCircleRoleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateCircleRoleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CreateCircleRoleFailure{type: $type, cause: $cause}';
}

enum CreateCircleRoleFailureType {
  unknown,
}
