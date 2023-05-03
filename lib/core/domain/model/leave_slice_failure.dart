import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LeaveSliceFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LeaveSliceFailure.unknown([this.cause]) : type = LeaveSliceFailureType.unknown;

  final LeaveSliceFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LeaveSliceFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LeaveSliceFailure{type: $type, cause: $cause}';
}

enum LeaveSliceFailureType {
  unknown,
}
