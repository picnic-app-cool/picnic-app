import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/settings/domain/model/get_notification_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';

class GetNotificationSettingsUseCase {
  const GetNotificationSettingsUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<GetNotificationSettingsFailure, NotificationSettings>> execute() async {
    return _privateProfileRepository.getNotificationSettings();
  }
}
