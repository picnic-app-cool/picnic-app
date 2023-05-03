import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class MentionUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const MentionUserFailure.unknown([this.cause]) : type = MentionUserFailureType.unknown;

  final MentionUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case MentionUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'MentionUserFailure{type: $type, cause: $cause}';
}

enum MentionUserFailureType {
  unknown,
}
