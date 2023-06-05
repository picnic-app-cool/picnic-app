import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnVotePodFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnVotePodFailure.unknown([this.cause]) : type = UnVotePodFailureType.unknown;

  final UnVotePodFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnVotePodFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnVotePodFailure{type: $type, cause: $cause}';
}

enum UnVotePodFailureType {
  unknown,
}
