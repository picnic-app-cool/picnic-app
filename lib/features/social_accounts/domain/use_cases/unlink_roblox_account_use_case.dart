import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_roblox_account_failure.dart';

class UnlinkRobloxAccountUseCase {
  const UnlinkRobloxAccountUseCase(this._socialAccountsRepository);

  final SocialAccountsRepository _socialAccountsRepository;

  Future<Either<UnlinkRobloxAccountFailure, Unit>> execute() async => _socialAccountsRepository.unlinkRobloxAccount();
}
