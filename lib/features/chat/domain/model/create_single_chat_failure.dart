import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CreateSingleChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateSingleChatFailure.unknown([this.cause]) : type = CreateSingleChatFailureType.unknown;

  const CreateSingleChatFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = CreateSingleChatFailureType.chatDoesNotExist;

  final CreateSingleChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateSingleChatFailureType.unknown:
      case CreateSingleChatFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CreateSingleChatFailure{type: $type, cause: $cause}';
}

enum CreateSingleChatFailureType {
  unknown,
  chatDoesNotExist,
}
