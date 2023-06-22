import 'package:picnic_app/core/data/graphql/model/gql_linked_discord_account.dart';
import 'package:picnic_app/core/data/graphql/model/gql_linked_roblox_account.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';

class GqlSocialAccounts {
  const GqlSocialAccounts({
    required this.linkedDiscordAccount,
    required this.linkedRobloxAccount,
  });

  //ignore: long-method
  factory GqlSocialAccounts.fromJson(Map<String, dynamic>? json) {
    GqlLinkedDiscordAccount? gqlLinkedDiscordAccount;
    GqlLinkedRobloxAccount? gqlLinkedRobloxAccount;
    if (json != null && json['discord'] != null) {
      gqlLinkedDiscordAccount = GqlLinkedDiscordAccount.fromJson(asT<Map<String, dynamic>>(json, 'discord'));
    }
    if (json != null && json['roblox'] != null) {
      gqlLinkedRobloxAccount = GqlLinkedRobloxAccount.fromJson(asT<Map<String, dynamic>>(json, 'roblox'));
    }
    return GqlSocialAccounts(
      linkedDiscordAccount: gqlLinkedDiscordAccount,
      linkedRobloxAccount: gqlLinkedRobloxAccount,
    );
  }

  final GqlLinkedDiscordAccount? linkedDiscordAccount;
  final GqlLinkedRobloxAccount? linkedRobloxAccount;

  LinkedSocialAccounts toDomain() {
    return LinkedSocialAccounts(
      discord: linkedDiscordAccount?.toDomain() ?? const LinkedDiscordAccount.empty(),
      roblox: linkedRobloxAccount?.toDomain() ?? const LinkedRobloxAccount.empty(),
      isDiscordLinked: linkedDiscordAccount != null,
      isRobloxLinked: linkedRobloxAccount != null,
    );
  }
}
