import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class VoteDirectorFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VoteDirectorFailure.unknown([this.cause]) : type = VoteDirectorFailureType.unknown;

  final VoteDirectorFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case VoteDirectorFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'VoteDirectorFailure{type: $type, cause: $cause}';
}

enum VoteDirectorFailureType {
  unknown,
}
