import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  const GetChatsUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<GetChatFailure, PaginatedList<BasicChat>>> execute({
    String? searchQuery,
    List<ChatType>? chatTypes,
    required Cursor nextPageCursor,
  }) async {
    return _chatRepository.getChats(
      searchQuery: searchQuery,
      chatTypes: chatTypes,
      nextPageCursor: nextPageCursor,
    );
  }
}
