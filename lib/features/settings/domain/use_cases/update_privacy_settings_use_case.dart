import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/settings/domain/model/update_privacy_settings_failure.dart';

class UpdatePrivacySettingsUseCase {
  const UpdatePrivacySettingsUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<UpdatePrivacySettingsFailure, Unit>> execute({required bool onlyDMFromFollowed}) async {
    return _privateProfileRepository.updatePrivacySettings(onlyDMFromFollowed: onlyDMFromFollowed);
  }
}
