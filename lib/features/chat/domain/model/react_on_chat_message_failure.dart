import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ReactOnChatMessageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ReactOnChatMessageFailure.unknown([this.cause]) : type = ReactOnChatMessageFailureType.unknown;

  const ReactOnChatMessageFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = ReactOnChatMessageFailureType.chatDoesNotExist;

  final ReactOnChatMessageFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ReactOnChatMessageFailureType.unknown:
      case ReactOnChatMessageFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ReactOnChatMessageFailure{type: $type, cause: $cause}';
}

enum ReactOnChatMessageFailureType {
  unknown,
  chatDoesNotExist,
}
