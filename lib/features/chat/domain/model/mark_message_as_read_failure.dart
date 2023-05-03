import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class MarkMessageAsReadFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const MarkMessageAsReadFailure.unknown([this.cause]) : type = MarkMessageAsReadFailureType.unknown;

  final MarkMessageAsReadFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case MarkMessageAsReadFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'MarkMessageAsReadFailure{type: $type, cause: $cause}';
}

enum MarkMessageAsReadFailureType {
  unknown,
}
