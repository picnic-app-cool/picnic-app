import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetCircleChatsUseCase {
  const GetCircleChatsUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<GetChatFailure, PaginatedList<Chat>>> execute({
    String? searchQuery,
    required Cursor nextPageCursor,
  }) async {
    return _chatRepository.getCircleChats(
      searchQuery: searchQuery,
      nextPageCursor: nextPageCursor,
    );
  }
}
