import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';

class RemoveInAppNotificationsFilterUseCase {
  const RemoveInAppNotificationsFilterUseCase(this._liveEventsRepository);

  final LiveEventsRepository _liveEventsRepository;

  void execute(NotificationsFilter filter) => _liveEventsRepository.removeNotificationsFilter(filter);
}
