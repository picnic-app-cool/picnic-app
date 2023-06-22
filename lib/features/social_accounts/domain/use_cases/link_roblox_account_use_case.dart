import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_roblox_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';

class LinkRobloxAccountUseCase {
  const LinkRobloxAccountUseCase(this._socialAccountsRepository);

  final SocialAccountsRepository _socialAccountsRepository;

  Future<Either<LinkRobloxAccountFailure, LinkedRobloxAccount>> execute({
    required LinkSocialAccountRequest linkSocialAccountRequest,
  }) async =>
      _socialAccountsRepository.linkRobloxAccount(linkSocialAccountRequest);
}
