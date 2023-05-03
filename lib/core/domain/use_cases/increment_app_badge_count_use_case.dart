import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';

class IncrementAppBadgeCountUseCase {
  const IncrementAppBadgeCountUseCase(this._userPreferencesRepository, this._updateAppBadgeCountUseCase);

  final UserPreferencesRepository _userPreferencesRepository;
  final UpdateAppBadgeCountUseCase _updateAppBadgeCountUseCase;

  Future<void> execute() async {
    final newCount = (await _userPreferencesRepository.getAppBadgeCount()).getOrElse(() => 0) + 1;
    await _updateAppBadgeCountUseCase.execute(newCount);
  }
}
