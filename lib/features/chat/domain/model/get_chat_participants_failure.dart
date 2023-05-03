import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetChatParticipantsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatParticipantsFailure.unknown([this.cause]) : type = GetChatParticipantsFailureType.unknown;

  final GetChatParticipantsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatParticipantsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatParticipantsFailure{type: $type, cause: $cause}';
}

enum GetChatParticipantsFailureType {
  unknown,
}
