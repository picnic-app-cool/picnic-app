import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_discord_account_failure.dart';

class UnlinkDiscordAccountUseCase {
  const UnlinkDiscordAccountUseCase(this._socialAccountsRepository);

  final SocialAccountsRepository _socialAccountsRepository;

  Future<Either<UnlinkDiscordAccountFailure, Unit>> execute() async => _socialAccountsRepository.unlinkDiscordAccount();
}
