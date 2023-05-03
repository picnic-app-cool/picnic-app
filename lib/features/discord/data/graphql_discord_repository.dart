import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discord/data/discord_queries.dart';
import 'package:picnic_app/features/discord/data/model/gql_configure_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/data/model/gql_discord_config_response.dart';
import 'package:picnic_app/features/discord/data/model/gql_revoke_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/model/configure_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/model/connect_discord_server_failure.dart';
import 'package:picnic_app/features/discord/domain/model/discord_config_response.dart';
import 'package:picnic_app/features/discord/domain/model/get_discord_config_failure.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_failure.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/repositories/discord_repository.dart';

class GraphqlDiscordRepository implements DiscordRepository {
  const GraphqlDiscordRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<ConnectDiscordServerFailure, Unit>> connectDiscordServer(ConfigureDiscordWebhookInput input) =>
      _gqlClient
          .mutate(
            document: connectWebhookMutation,
            variables: {
              'configureDiscordWebhookInput': input.toJson(),
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['configureDiscordWebhook'] as Map<String, dynamic>),
          )
          .mapFailure(ConnectDiscordServerFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const ConnectDiscordServerFailure.unknown());

  @override
  Future<Either<RevokeDiscordWebhookFailure, Unit>> revokeWebhook(RevokeDiscordWebhookInput input) => _gqlClient
      .mutate(
        document: revokeWebhookMutation,
        variables: {
          'revokeDiscordWebhookInput': input.toJson(),
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['revokeDiscordWebhook'] as Map<String, dynamic>),
      )
      .mapFailure(RevokeDiscordWebhookFailure.unknown)
      .mapSuccessPayload(onFailureReturn: const RevokeDiscordWebhookFailure.unknown());

  @override
  Future<Either<GetDiscordConfigFailure, DiscordConfigResponse>> getDiscordConfig({
    required Id circleId,
  }) =>
      _gqlClient
          .query(
            document: getDiscordConfigQuery,
            variables: {
              'circleId': circleId.value,
            },
            parseData: (json) => GqlDiscordConfigResponse.fromJson(json['getDiscordConfig'] as Map<String, dynamic>),
          )
          .mapFailure(GetDiscordConfigFailure.unknown)
          .mapSuccess((response) => response.toDomain());
}
