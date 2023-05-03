import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LeaveCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LeaveCircleFailure.unknown([this.cause]) : type = LeaveCircleFailureType.unknown;

  final LeaveCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LeaveCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LeaveCircleFailure{type: $type, cause: $cause}';
}

enum LeaveCircleFailureType {
  unknown,
}
