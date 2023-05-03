//ignore_for_file: unused-code, unused-files
import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/delete_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class DeleteMessageUseCase {
  const DeleteMessageUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<DeleteChatMessageFailure, Unit>> execute({
    required Id messageId,
  }) =>
      _chatRepository.deleteMessage(
        messageId: messageId,
      );
}
