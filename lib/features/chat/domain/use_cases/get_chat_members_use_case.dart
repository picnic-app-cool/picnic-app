import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_members_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatMembersUseCase {
  const GetChatMembersUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<GetChatMembersFailure, PaginatedList<ChatMember>>> execute({
    required Id chatId,
    required Cursor nextPageCursor,
  }) async =>
      _repository.getChatMembers(
        chatId: chatId,
        nextPageCursor: nextPageCursor,
      );
}
