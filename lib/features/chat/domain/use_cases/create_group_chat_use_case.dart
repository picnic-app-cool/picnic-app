import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/create_group_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class CreateGroupChatUseCase {
  const CreateGroupChatUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<CreateGroupChatFailure, BasicChat>> execute({
    required String name,
    required List<Id> userIds,
  }) async =>
      _chatRepository.createGroupChat(
        name: name,
        userIds: userIds,
      );
}
