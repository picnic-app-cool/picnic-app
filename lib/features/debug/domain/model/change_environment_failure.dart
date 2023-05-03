import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ChangeEnvironmentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ChangeEnvironmentFailure.unknown([this.cause]) : type = ChangeEnvironmentFailureType.unknown;

  final ChangeEnvironmentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ChangeEnvironmentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ChangeEnvironmentFailure{type: $type, cause: $cause}';
}

enum ChangeEnvironmentFailureType {
  unknown,
}
