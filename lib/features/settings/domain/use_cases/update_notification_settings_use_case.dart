import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/model/update_notification_settings_failure.dart';

class UpdateNotificationSettingsUseCase {
  const UpdateNotificationSettingsUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;
  Future<Either<UpdateNotificationSettingsFailure, dynamic>> execute({
    required NotificationSettings notificationSettings,
  }) async {
    return _privateProfileRepository.updateNotificationSettings(notificationSettings: notificationSettings);
  }
}
