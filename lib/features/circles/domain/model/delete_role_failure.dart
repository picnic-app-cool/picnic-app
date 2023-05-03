import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DeleteRoleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteRoleFailure.unknown([this.cause]) : type = DeleteRoleFailureType.unknown;

  final DeleteRoleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteRoleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DeleteRoleFailure{type: $type, cause: $cause}';
}

enum DeleteRoleFailureType {
  unknown,
}
