//ignore_for_file: no-magic-number
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_chat_settings.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/data/chat_queries.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_settings_input.dart';
import 'package:picnic_app/features/chat/domain/model/add_user_to_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_participants_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/invite_user_to_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/remove_user_from_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/update_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlChatSettingsRepository with FutureRetarder implements ChatSettingsRepository {
  GraphqlChatSettingsRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetChatSettingsFailure, ChatSettings>> getChatSettings({required Id chatId}) => _gqlClient
      .query(
        document: chatSettingsQuery,
        variables: {
          'chatId': chatId.value,
        },
        parseData: (json) {
          final data = json['chatSettings'] as Map<String, dynamic>;
          return GqlChatSettings.fromJson(data);
        },
      )
      .mapFailure(GetChatSettingsFailure.unknown)
      .mapSuccess((response) => response.toDomain());

  @override
  Future<Either<InviteUserToChatFailure, Unit>> inviteUserToChat({
    required Id chatId,
    required List<Id> userIds,
  }) async {
    await randomSleep();
    return success(unit);
  }

  @override
  Future<Either<UpdateChatSettingsFailure, Unit>> updateChatSettings({
    required Id chatId,
    required ChatSettings settings,
  }) =>
      _gqlClient
          .mutate(
            document: updateChatSettingsMutation,
            variables: {
              'chatId': chatId.value,
              'settings': GqlChatSettingsInput(isMuted: settings.isMuted),
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['updateChatSettings'] as Map<String, dynamic>),
          )
          .mapFailure(UpdateChatSettingsFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const UpdateChatSettingsFailure.unknown());

  @override
  Future<Either<UpdateChatSettingsFailure, Unit>> updateChatName({
    required Id chatId,
    required String name,
  }) =>
      _gqlClient
          .mutate(
            document: updateChatSettingsMutation,
            variables: {
              'chatId': chatId.value,
              'settings': GqlChatSettingsInput(name: name),
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['updateChatSettings'] as Map<String, dynamic>),
          )
          .mapFailure(UpdateChatSettingsFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const UpdateChatSettingsFailure.unknown());

  @override
  Future<Either<AddUserToChatFailure, Unit>> addUserToChat({
    required Id chatId,
    required Id userId,
  }) =>
      _gqlClient
          .mutate(
            document: addUserToChatMutation,
            variables: {
              'chatId': chatId.value,
              'userId': userId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['addUserToChat'] as Map<String, dynamic>),
          )
          .mapFailure(AddUserToChatFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const AddUserToChatFailure.unknown());

  @override
  Future<Either<RemoveUserFromChatFailure, Unit>> removeUserFromChat({
    required Id chatId,
    required Id userId,
  }) =>
      _gqlClient
          .mutate(
            document: removeUserFromChatMutation,
            variables: {
              'chatId': chatId.value,
              'userId': userId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['removeUserFromChat'] as Map<String, dynamic>),
          )
          .mapFailure(RemoveUserFromChatFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const RemoveUserFromChatFailure.unknown());

  @override
  Future<Either<GetChatParticipantsFailure, PaginatedList<User>>> getChatParticipants({
    required Id chatId,
    required Cursor nextPageCursor,
  }) =>
      _gqlClient
          .query(
            document: chatParticipantsQuery,
            variables: {
              'chatId': chatId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final chatData = json['chat'] as Map<String, dynamic>;
              final participants = chatData['participantsConnection'] as Map<String, dynamic>;
              return GqlConnection.fromJson(participants);
            },
          )
          .mapFailure(GetChatParticipantsFailure.unknown)
          .mapSuccess(
            (participants) => participants.toDomain(
              nodeMapper: (node) => GqlUser.fromJson(node).toDomain(),
            ),
          );
}
