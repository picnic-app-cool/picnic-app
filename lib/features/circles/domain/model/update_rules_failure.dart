import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateRulesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateRulesFailure.unknown([this.cause]) : type = EditRulesFailureType.unknown;

  final EditRulesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case EditRulesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'EditRulesFailure{type: $type, cause: $cause}';
}

enum EditRulesFailureType {
  unknown,
}
