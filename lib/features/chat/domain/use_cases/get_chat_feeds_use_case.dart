import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat_excerpt.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_feeds_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatFeedsUseCase {
  const GetChatFeedsUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Either<GetChatFeedsFailure, PaginatedList<ChatExcerpt>>> execute({
    Cursor? nextPageCursor,
  }) =>
      _chatRepository.getChatFeeds(
        nextPageCursor: nextPageCursor,
      );
}
