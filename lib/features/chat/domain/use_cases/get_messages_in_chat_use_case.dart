import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_messages_list_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetMessagesInChatUseCase {
  const GetMessagesInChatUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<GetChatMessagesListFailure, PaginatedList<ChatMessage>>> execute({
    required Id chatId,
    required Cursor nextPageCursor,
  }) async {
    return _chatRepository.getMessagesInChat(
      chatId: chatId,
      nextPageCursor: nextPageCursor,
    );
  }
}
