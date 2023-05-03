import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/get_single_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetSingleChatMessageUseCase {
  const GetSingleChatMessageUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<GetSingleChatMessageFailure, ChatMessage>> execute({
    required Id chatId,
    required Id messageId,
  }) async {
    return _chatRepository.getSingleChatMessage(
      chatId: chatId,
      messageId: messageId,
    );
  }
}
