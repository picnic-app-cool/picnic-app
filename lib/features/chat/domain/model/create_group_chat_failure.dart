import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CreateGroupChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateGroupChatFailure.unknown([this.cause]) : type = CreateGroupChatFailureType.unknown;

  const CreateGroupChatFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = CreateGroupChatFailureType.chatDoesNotExist;

  final CreateGroupChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateGroupChatFailureType.unknown:
      case CreateGroupChatFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CreateGroupChatFailure{type: $type, cause: $cause}';
}

enum CreateGroupChatFailureType {
  unknown,
  chatDoesNotExist,
}
