import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class JoinChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const JoinChatFailure.unknown([this.cause]) : type = JoinChatFailureType.unknown;

  const JoinChatFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = JoinChatFailureType.chatDoesNotExist;

  final JoinChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case JoinChatFailureType.unknown:
      case JoinChatFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'JoinChatFailure{type: $type, cause: $cause}';
}

enum JoinChatFailureType {
  unknown,
  chatDoesNotExist,
}
