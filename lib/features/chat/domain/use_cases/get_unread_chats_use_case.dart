import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/get_unread_chats_failure.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetUnreadChatsUseCase {
  const GetUnreadChatsUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<GetUnreadChatsFailure, List<UnreadChat>>> execute() async {
    return _repository.getUnreadChats();
  }
}
