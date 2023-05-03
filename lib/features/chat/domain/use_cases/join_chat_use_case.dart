import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/join_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class JoinChatUseCase {
  const JoinChatUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<JoinChatFailure, Unit>> execute({required Id chatId}) async {
    return _chatRepository.joinChat(chatId: chatId);
  }
}
