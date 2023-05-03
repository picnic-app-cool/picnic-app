import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_members_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_members_use_case.dart';

class GetChatUseCase {
  const GetChatUseCase(
    this._chatRepository,
    this._getChatMembersUseCase,
    this._userStore,
  );

  final ChatRepository _chatRepository;
  final GetChatMembersUseCase _getChatMembersUseCase;
  final UserStore _userStore;

  Future<Either<GetChatFailure, Chat>> execute({
    required Id chatId,
  }) async =>
      _chatRepository.getChat(chatId: chatId).flatMap((chat) async {
        // This check is necessary because yet we can't get all circle members
        // by one request from the BE due to cursor limitation.
        if (chat.chatType == ChatType.circle) {
          return success(chat);
        }

        final result = await _getChatMembers(chat);

        final members = result.getSuccess();
        if (members == null) {
          return failure(const GetChatFailure.unknown());
        }

        final isMember = members.items.any(
          (element) => element.userId == _userStore.privateProfile.id,
        );

        return isMember ? success(chat) : failure(const GetChatFailure.forbiddenAccess());
      });

  Future<Either<GetChatMembersFailure, PaginatedList<ChatMember>>> _getChatMembers(Chat chat) =>
      _getChatMembersUseCase.execute(
        chatId: chat.id,
        nextPageCursor: Cursor.firstPage(
          pageSize: chat.participantsCount,
        ),
      );
}
