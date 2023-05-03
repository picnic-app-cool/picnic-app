import 'package:picnic_app/core/domain/repositories/app_badge_repository.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';

class UpdateAppBadgeCountUseCase {
  const UpdateAppBadgeCountUseCase(this._appBadgeRepository, this._userPreferencesRepository);

  final AppBadgeRepository _appBadgeRepository;
  final UserPreferencesRepository _userPreferencesRepository;

  Future<void> execute(int count) async {
    await Future.wait([
      _userPreferencesRepository.setAppBadgeCount(count),
      _appBadgeRepository.updateAppBadgeCount(count),
    ]);
  }
}
