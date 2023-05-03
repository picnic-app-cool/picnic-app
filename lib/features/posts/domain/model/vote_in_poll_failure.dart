import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class VoteInPollFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VoteInPollFailure.unknown([this.cause]) : type = VoteInPollFailureType.unknown;

  final VoteInPollFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case VoteInPollFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'VoteInPollFailure{type: $type, cause: $cause}';
}

enum VoteInPollFailureType {
  unknown,
}
