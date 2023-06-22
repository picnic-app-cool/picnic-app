import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';
import 'package:picnic_app/features/social_accounts/domain/model/get_connected_social_accounts_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_roblox_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_roblox_account_failure.dart';

abstract class SocialAccountsRepository {
  Future<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>> getConnectedSocialAccounts();

  Future<Either<LinkDiscordAccountFailure, LinkedDiscordAccount>> linkDiscordAccount(
    LinkSocialAccountRequest linkSocialAccountRequest,
  );

  Future<Either<LinkRobloxAccountFailure, LinkedRobloxAccount>> linkRobloxAccount(
    LinkSocialAccountRequest linkSocialAccountRequest,
  );

  Future<Either<UnlinkDiscordAccountFailure, Unit>> unlinkDiscordAccount();

  Future<Either<UnlinkRobloxAccountFailure, Unit>> unlinkRobloxAccount();
}
