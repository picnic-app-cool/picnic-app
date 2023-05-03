import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/settings/domain/model/get_privacy_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';

class GetPrivacySettingsUseCase {
  const GetPrivacySettingsUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<GetPrivacySettingsFailure, PrivacySettings>> execute() async =>
      _privateProfileRepository.getPrivacySettings();
}
