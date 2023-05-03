import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SetShouldShowCirclesSelectionFailure implements HasDisplayableFailure {
  const SetShouldShowCirclesSelectionFailure.unknown([this.cause])
      // ignore: avoid_field_initializers_in_const_classes
      : type = SetShouldShowCirclesSelectionFailureType.unknown;

  final SetShouldShowCirclesSelectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SetShouldShowCirclesSelectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SetShouldShowCirclesSelectionFailure{type: $type, cause: $cause}';
}

enum SetShouldShowCirclesSelectionFailureType {
  unknown,
}
