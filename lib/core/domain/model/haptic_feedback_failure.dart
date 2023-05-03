import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class HapticFeedbackFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const HapticFeedbackFailure.unknown([this.cause]) : type = HapticFeedbackFailureType.unknown;

  final HapticFeedbackFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case HapticFeedbackFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'HapticFeedbackFailure{type: $type, cause: $cause}';
}

enum HapticFeedbackFailureType {
  unknown,
}
