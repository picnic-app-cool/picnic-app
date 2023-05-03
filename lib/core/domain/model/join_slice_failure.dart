import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class JoinSliceFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const JoinSliceFailure.unknown([this.cause]) : type = JoinSliceFailureType.unknown;

  final JoinSliceFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case JoinSliceFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'JoinSliceFailure{type: $type, cause: $cause}';
}

enum JoinSliceFailureType {
  unknown,
}
