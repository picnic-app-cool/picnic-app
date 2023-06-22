import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';

class LinkDiscordAccountUseCase {
  const LinkDiscordAccountUseCase(this._socialAccountsRepository);

  final SocialAccountsRepository _socialAccountsRepository;

  Future<Either<LinkDiscordAccountFailure, LinkedDiscordAccount>> execute({
    required LinkSocialAccountRequest linkSocialAccountRequest,
  }) async =>
      _socialAccountsRepository.linkDiscordAccount(linkSocialAccountRequest);
}
