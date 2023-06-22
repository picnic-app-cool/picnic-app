import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';
import 'package:picnic_app/features/social_accounts/domain/model/get_connected_social_accounts_failure.dart';

class GetConnectedSocialAccountsUseCase {
  const GetConnectedSocialAccountsUseCase(this._socialAccountsRepository);

  final SocialAccountsRepository _socialAccountsRepository;

  Future<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>> execute() async {
    return _socialAccountsRepository.getConnectedSocialAccounts();
  }
}
