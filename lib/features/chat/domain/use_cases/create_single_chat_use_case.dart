import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/create_single_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class CreateSingleChatUseCase {
  const CreateSingleChatUseCase(this._chatRepository);

  static const int singleChatMaxCount = 2;
  final ChatRepository _chatRepository;

  Future<Either<CreateSingleChatFailure, BasicChat>> execute({
    required List<Id> userIds,
  }) async {
    assert(userIds.length == singleChatMaxCount);
    return _chatRepository.createSingleChat(
      userIds: userIds,
    );
  }
}
