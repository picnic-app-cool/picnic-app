import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/send_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class SendChatMessageUseCase {
  const SendChatMessageUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<SendChatMessageFailure, ChatMessage>> execute({
    required Id chatId,
    required ChatMessageInput message,
  }) async =>
      _chatRepository.sendChatMessage(
        chatId: chatId,
        message: message,
      );
}
