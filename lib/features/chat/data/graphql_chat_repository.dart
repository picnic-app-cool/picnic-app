import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_chat_member_json.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/data/chat_queries.dart';
import 'package:picnic_app/features/chat/data/model/gql_basic_chat_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_excerpt_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_input_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_reaction_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_meta_data_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_group_chat_input_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_single_chat_input_json.dart';
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
import 'package:picnic_app/features/chat/domain/model/group_chat_input.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/join_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/leave_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/mark_message_as_read_failure.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/react_on_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/send_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/single_chat_input.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlChatRepository with FutureRetarder implements ChatRepository {
  GraphqlChatRepository(
    this.gqlClient,
  );

  static const permissionDenied = 'PermissionDenied';

  final GraphQLClient gqlClient;

  @override
  Future<Either<DeleteChatMessageFailure, Unit>> deleteMessage({
    required Id messageId,
  }) =>
      gqlClient
          .mutate(
            document: deleteMessageMutation,
            variables: {
              'messageId': messageId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['deleteMessage'] as Map<String, dynamic>),
          )
          .mapFailure(DeleteChatMessageFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const DeleteChatMessageFailure.unknown());

  @override
  Future<Either<GetChatFailure, Chat>> getChat({required Id chatId}) async => gqlClient
      .query(
        document: chatQuery,
        variables: {
          'chatId': chatId.value,
        },
        parseData: (json) {
          final data = json['chat'] as Map<String, dynamic>;
          return GqlChatJson.fromJson(data);
        },
      )
      .mapSuccess(
        (chatJson) => chatJson.toDomain(),
      )
      .mapFailure(GetChatFailure.unknown);

  @override
  Future<Either<GetChatFailure, PaginatedList<BasicChat>>> getChats({
    String? searchQuery,
    List<ChatType>? chatTypes,
    required Cursor nextPageCursor,
  }) =>
      gqlClient
          .query(
            document: getChatsQuery,
            variables: {
              'searchQuery': searchQuery,
              'chatTypes': chatTypes,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['chatsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetChatFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlBasicChatJson.fromJson(node).toDomain()),
          );

  @override
  Future<Either<GetChatFeedsFailure, PaginatedList<ChatExcerpt>>> getChatFeeds({
    Cursor? nextPageCursor,
  }) =>
      gqlClient
          .query(
            document: getChatFeedsQuery,
            variables: {
              if (nextPageCursor != null) 'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['chatFeedConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetChatFeedsFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlChatExcerptJson.fromJson(node).toDomain()),
          );

  @override
  //ignore: long-method
  Future<Either<GetChatMessagesListFailure, PaginatedList<ChatMessage>>> getMessagesInChat({
    required Id chatId,
    required Cursor nextPageCursor,
  }) async =>
      gqlClient
          .query(
            document: chatMessagesQuery,
            variables: {
              'chatId': chatId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final chatData = json['chat'] as Map<String, dynamic>;
              final messages = chatData['messagesConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(messages);
            },
          )
          .mapFailure(GetChatMessagesListFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlChatMessageJson.fromJson(node).toDomain(),
            ),
          );

  @override
  Future<Either<GetSingleChatMessageFailure, ChatMessage>> getSingleChatMessage({
    required Id chatId,
    required Id messageId,
  }) async {
    //TODO GS-2904: We do not use it for V1
    return success(const ChatMessage.empty());
  }

  @override
  Future<Either<LeaveChatFailure, Unit>> leaveChat({
    required Id chatId,
  }) {
    return gqlClient
        .mutate(
          document: leaveChatMutation,
          variables: {
            'chatId': chatId.value,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['leaveChat'] as Map<String, dynamic>),
        )
        .mapFailure(LeaveChatFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const LeaveChatFailure.unknown());
  }

  @override
  Future<Either<JoinChatFailure, Unit>> joinChat({
    required Id chatId,
  }) async {
    return gqlClient
        .query(
          document: joinChatQuery,
          variables: {
            'chatId': chatId.value,
          },
          parseData: (json) {
            return unit;
          },
        )
        .mapFailure(JoinChatFailure.unknown)
        .mapSuccess((result) => result);
  }

  @override
  Future<Either<SendChatMessageFailure, ChatMessage>> sendChatMessage({
    required Id chatId,
    required ChatMessageInput message,
  }) {
    return gqlClient
        .mutate(
          document: sendMessageMutation,
          variables: {
            'chatId': chatId.value,
            'message': message.toJson(),
          },
          parseData: (json) => GqlChatMessageJson.fromJson(json["sendChatMessage"] as Map<String, dynamic>),
        )
        .mapSuccess((result) => result.toDomain())
        .mapFailure(
          (fail) => fail.errorCode == permissionDenied
              ? SendChatMessageFailure.permissionDenied(fail)
              : SendChatMessageFailure.unknown(fail),
        );
  }

  @override
  Future<Either<ReactOnChatMessageFailure, ChatMessageReaction>> reactToMessage({
    required Id messageId,
    required ChatMessageReactionType reactionType,
  }) =>
      gqlClient
          .mutate(
            document: reactToMessageMutation,
            variables: {
              'messageId': messageId.value,
              'reaction': reactionType.value,
            },
            parseData: (json) => GqlChatMessageReactionJson.fromJson(json["reactToMessage"] as Map<String, dynamic>),
          )
          .mapFailure(ReactOnChatMessageFailure.unknown)
          .mapSuccess(
            (response) => response.toDomain(),
          );

  @override
  Future<Either<ReactOnChatMessageFailure, ChatMessageReaction>> unreactToMessage({
    required Id messageId,
    required ChatMessageReactionType reactionType,
  }) =>
      gqlClient
          .mutate(
            document: unreactToMessageMutation,
            variables: {
              'messageId': messageId.value,
              'reaction': reactionType.value,
            },
            parseData: (json) => GqlChatMessageReactionJson.fromJson(json["unreactToMessage"] as Map<String, dynamic>),
          )
          .mapFailure(ReactOnChatMessageFailure.unknown)
          .mapSuccess(
            (response) => response.toDomain(),
          );

  @override
  Future<Either<CreateGroupChatFailure, BasicChat>> createGroupChat({
    required String name,
    required List<Id> userIds,
  }) =>
      gqlClient
          .mutate(
            document: createGroupChatMutation,
            variables: {
              'chatConfiguration': GroupChatInput(name: name, userIds: userIds).toJson(),
            },
            parseData: (json) => GqlBasicChatJson.fromJson(json["createGroupChat"] as Map<String, dynamic>),
          )
          .mapFailure(CreateGroupChatFailure.unknown)
          .mapSuccess(
            (chatResponse) => chatResponse.toDomain(),
          );

  @override
  Future<Either<CreateSingleChatFailure, BasicChat>> createSingleChat({required List<Id> userIds}) => gqlClient
      .mutate(
        document: createSingleChatMutation,
        variables: {
          'chatConfiguration': SingleChatInput(userIds: userIds).toJson(),
        },
        parseData: (json) => GqlBasicChatJson.fromJson(json["createSingleChat"] as Map<String, dynamic>),
      )
      .mapFailure(CreateSingleChatFailure.unknown)
      .mapSuccess(
        (chatResponse) => chatResponse.toDomain(),
      );

  @override
  Future<Either<GetChatFailure, PaginatedList<Chat>>> getCircleChats({
    String? searchQuery,
    required Cursor nextPageCursor,
  }) =>
      gqlClient
          .query(
            document: getChatsWithCircleQuery,
            variables: {
              'searchQuery': searchQuery,
              'chatTypes': [ChatType.circle],
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = json['chatsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetChatFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(nodeMapper: (node) => GqlChatJson.fromJson(node).toDomain()),
          );

  @override
  Future<Either<GetChatMembersFailure, PaginatedList<ChatMember>>> getChatMembers({
    required Id chatId,
    required Cursor nextPageCursor,
  }) =>
      gqlClient
          .query(
            document: chatMembersQuery,
            variables: {
              'chatId': chatId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final chatData = json['chat'] as Map<String, dynamic>;
              final members = chatData['membersConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(members);
            },
          )
          .mapFailure(GetChatMembersFailure.unknown)
          .mapSuccess(
            (members) => members.toDomain(
              nodeMapper: (node) => GqlChatMemberJson.fromJson(node).toDomain(),
            ),
          );

  @override
  Future<Either<GetUnreadChatsFailure, List<UnreadChat>>> getUnreadChats() => gqlClient
      .query(
        document: unreadChatsQuery,
        parseData: (json) {
          return asList(
            json,
            'unreadChats',
            GqlChatMetaDataJson.fromJson,
          );
        },
      )
      .mapFailure(GetUnreadChatsFailure.unknown)
      .mapSuccess(
        (chatsMetaData) => chatsMetaData.map((metaData) => metaData.toDomain()).toList(),
      );

  @override
  Future<Either<MarkMessageAsReadFailure, Unit>> markMessageAsRead({required Id lastSeenMessageId}) => gqlClient
      .query(
        document: markMessageAsReadQuery,
        variables: {
          'messageId': lastSeenMessageId.value,
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['markMessageAsRead'] as Map<String, dynamic>),
      )
      .mapFailure(MarkMessageAsReadFailure.unknown)
      .mapSuccessPayload(onFailureReturn: const MarkMessageAsReadFailure.unknown());
}
