import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnbanUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnbanUserFailure.unknown([this.cause]) : type = UnbanUserFailureType.unknown;

  final UnbanUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnbanUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleDetailsFailure{type: $type, cause: $cause}';
}

enum UnbanUserFailureType {
  unknown,
}
