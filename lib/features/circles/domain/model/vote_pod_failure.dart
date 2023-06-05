import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class VotePodFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VotePodFailure.unknown([this.cause]) : type = VotePodFailureType.unknown;

  final VotePodFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case VotePodFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'VotePodFailure{type: $type, cause: $cause}';
}

enum VotePodFailureType {
  unknown,
}
