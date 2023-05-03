import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';

class ToggleInAppNotificationsUseCase {
  const ToggleInAppNotificationsUseCase(this._liveEventsRepository);

  final LiveEventsRepository _liveEventsRepository;

  Future<void> execute({required bool enable}) async {
    return _liveEventsRepository.switchInAppNotifications(enable: enable);
  }
}
