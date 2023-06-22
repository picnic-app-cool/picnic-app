import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_link_social_account_request.dart';
import 'package:picnic_app/core/data/graphql/model/gql_linked_discord_account.dart';
import 'package:picnic_app/core/data/graphql/model/gql_linked_roblox_account.dart';
import 'package:picnic_app/core/data/graphql/model/gql_social_accounts.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/social_accounts_queries.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';
import 'package:picnic_app/features/social_accounts/domain/model/get_connected_social_accounts_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_roblox_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_roblox_account_failure.dart';

class GraphqlSocialAccountsRepository implements SocialAccountsRepository {
  const GraphqlSocialAccountsRepository(this._gqlClient);

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>> getConnectedSocialAccounts() async {
    return _gqlClient
        .query(
          document: getConnectedSocialAccountsQuery,
          parseData: (json) => GqlSocialAccounts.fromJson(json['getLinkedAccounts'] as Map<String, dynamic>),
        )
        .mapFailure(GetConnectedSocialAccountsFailure.unknown)
        .mapSuccess((result) => result.toDomain());
  }

  @override
  Future<Either<LinkDiscordAccountFailure, LinkedDiscordAccount>> linkDiscordAccount(
    LinkSocialAccountRequest linkSocialAccountRequest,
  ) async {
    return _gqlClient
        .query(
          document: linkDiscordAccountMutation,
          variables: {
            'request': linkSocialAccountRequest.toJson(),
          },
          parseData: (json) {
            final data = asT<Map<String, dynamic>>(json, "linkDiscordAccount");
            return GqlLinkedDiscordAccount.fromJson(data['account'] as Map<String, dynamic>);
          },
        )
        .mapFailure(LinkDiscordAccountFailure.unknown)
        .mapSuccess((result) => result.toDomain());
  }

  @override
  Future<Either<LinkRobloxAccountFailure, LinkedRobloxAccount>> linkRobloxAccount(
    LinkSocialAccountRequest linkSocialAccountRequest,
  ) async {
    return _gqlClient
        .query(
          document: linkRobloxAccountMutation,
          variables: {
            'request': linkSocialAccountRequest.toJson(),
          },
          parseData: (json) {
            final data = asT<Map<String, dynamic>>(json, "linkRobloxAccount");
            return GqlLinkedRobloxAccount.fromJson(data['account'] as Map<String, dynamic>);
          },
        )
        .mapFailure(LinkRobloxAccountFailure.unknown)
        .mapSuccess((result) => result.toDomain());
  }

  @override
  Future<Either<UnlinkRobloxAccountFailure, Unit>> unlinkRobloxAccount() async {
    return _gqlClient
        .query(
          document: unlinkRobloxAccountMutation,
          parseData: (json) => GqlSuccessPayload.fromJson(json['unlinkRobloxAccount'] as Map<String, dynamic>),
        )
        .mapFailure(UnlinkRobloxAccountFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const UnlinkRobloxAccountFailure.unknown());
  }

  @override
  Future<Either<UnlinkDiscordAccountFailure, Unit>> unlinkDiscordAccount() async {
    return _gqlClient
        .query(
          document: unlinkDiscordAccountMutation,
          parseData: (json) => GqlSuccessPayload.fromJson(json['unlinkDiscordAccount'] as Map<String, dynamic>),
        )
        .mapFailure(UnlinkDiscordAccountFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const UnlinkDiscordAccountFailure.unknown());
  }
}
