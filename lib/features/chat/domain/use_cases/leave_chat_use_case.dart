import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/leave_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class LeaveChatUseCase {
  const LeaveChatUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<LeaveChatFailure, Unit>> execute({required Id chatId}) async {
    return _chatRepository.leaveChat(chatId: chatId);
  }
}
