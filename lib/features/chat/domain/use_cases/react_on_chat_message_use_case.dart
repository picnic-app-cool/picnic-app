import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/react_on_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class ReactOnChatMessageUseCase {
  const ReactOnChatMessageUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<ReactOnChatMessageFailure, ChatMessageReaction>> execute({
    required Id messageId,
    required ReactOnChatMessageAction action,
    required ChatMessageReactionType reactionType,
  }) async {
    switch (action) {
      case ReactOnChatMessageAction.react:
        return _chatRepository.reactToMessage(
          messageId: messageId,
          reactionType: reactionType,
        );
      case ReactOnChatMessageAction.unreact:
        return _chatRepository.unreactToMessage(
          messageId: messageId,
          reactionType: reactionType,
        );
    }
  }
}

enum ReactOnChatMessageAction {
  react,
  unreact,
}
