import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_recommended_chats_failure.dart';
import 'package:picnic_app/core/domain/model/get_recommended_chats_input.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_excerpt.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/create_group_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/create_single_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/delete_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_feeds_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_members_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_messages_list_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_single_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_unread_chats_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/join_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/leave_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/mark_message_as_read_failure.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/react_on_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/send_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';

abstract class ChatRepository {
  // -------
  // Message
  // -------
  Future<Either<SendChatMessageFailure, ChatMessage>> sendChatMessage({
    required Id chatId,
    required ChatMessageInput message,
  });

  Future<Either<GetSingleChatMessageFailure, ChatMessage>> getSingleChatMessage({
    required Id chatId,
    required Id messageId,
  });

  /// retrieves the messages from chat, first page will contain 10 most recent messages, where first message in the list is the latest one
  /// to retrieve older messages, use `previousPageId` to fetch previous page of messages
  Future<Either<GetChatMessagesListFailure, PaginatedList<ChatMessage>>> getMessagesInChat({
    required Id chatId,
    required Cursor nextPageCursor,
  });

  Future<Either<DeleteChatMessageFailure, Unit>> deleteMessage({
    required Id messageId,
  });

  // -------
  // Chat
  // -------
  Future<Either<GetChatFailure, Chat>> getChat({
    required Id chatId,
  });

  Future<Either<GetChatFailure, PaginatedList<BasicChat>>> getChats({
    String? searchQuery,
    List<ChatType>? chatTypes,
    required Cursor nextPageCursor,
  });

  Future<Either<GetChatFailure, PaginatedList<Chat>>> getCircleChats({
    String? searchQuery,
    required Cursor nextPageCursor,
  });

  Future<Either<GetRecommendedChatsFailure, PaginatedList<Chat>>> getRecommendedChats({
    required GetRecommendedChatsInput input,
  });

  Future<Either<GetChatFeedsFailure, PaginatedList<ChatExcerpt>>> getChatFeeds({
    Cursor? nextPageCursor,
  });

  Future<Either<LeaveChatFailure, Unit>> leaveChat({
    required Id chatId,
  });

  Future<Either<JoinChatFailure, Unit>> joinChat({
    required Id chatId,
  });

  Future<Either<ReactOnChatMessageFailure, ChatMessageReaction>> reactToMessage({
    required Id messageId,
    required ChatMessageReactionType reactionType,
  });

  Future<Either<ReactOnChatMessageFailure, ChatMessageReaction>> unreactToMessage({
    required Id messageId,
    required ChatMessageReactionType reactionType,
  });

  Future<Either<CreateGroupChatFailure, BasicChat>> createGroupChat({
    required String name,
    required List<Id> userIds,
  });

  Future<Either<CreateSingleChatFailure, BasicChat>> createSingleChat({
    required List<Id> userIds,
  });

  Future<Either<GetChatMembersFailure, PaginatedList<ChatMember>>> getChatMembers({
    required Id chatId,
    required Cursor nextPageCursor,
  });

  Future<Either<GetUnreadChatsFailure, List<UnreadChat>>> getUnreadChats();

  Future<Either<MarkMessageAsReadFailure, Unit>> markMessageAsRead({required Id lastSeenMessageId});
}
