import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class JoinCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const JoinCircleFailure.unknown([this.cause]) : type = JoinCircleFailureType.unknown;

  final JoinCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case JoinCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'JoinCircleFailure{type: $type, cause: $cause}';
}

enum JoinCircleFailureType {
  unknown,
}
