import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetShouldShowCirclesSelectionFailure implements HasDisplayableFailure {
  const GetShouldShowCirclesSelectionFailure.unknown([this.cause])
      // ignore: avoid_field_initializers_in_const_classes
      : type = GetShouldShowCirclesSelectionFailureType.unknown;

  final GetShouldShowCirclesSelectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetShouldShowCirclesSelectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetShouldShowCirclesSelectionFailure{type: $type, cause: $cause}';
}

enum GetShouldShowCirclesSelectionFailureType {
  unknown,
}
