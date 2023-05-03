import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class LeaveChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LeaveChatFailure.unknown([this.cause]) : type = LeaveChatFailureType.unknown;

  const LeaveChatFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = LeaveChatFailureType.chatDoesNotExist;

  final LeaveChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LeaveChatFailureType.unknown:
      case LeaveChatFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LeaveChatFailure{type: $type, cause: $cause}';
}

enum LeaveChatFailureType {
  unknown,
  chatDoesNotExist,
}
