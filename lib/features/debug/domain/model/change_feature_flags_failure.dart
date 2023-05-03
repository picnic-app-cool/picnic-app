import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ChangeFeatureFlagsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ChangeFeatureFlagsFailure.unknown([this.cause]) : type = ChangeFeatureFlagsFailureType.unknown;

  final ChangeFeatureFlagsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ChangeFeatureFlagsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ChangeFeatureFlagsFailure{type: $type, cause: $cause}';
}

enum ChangeFeatureFlagsFailureType {
  unknown,
}
