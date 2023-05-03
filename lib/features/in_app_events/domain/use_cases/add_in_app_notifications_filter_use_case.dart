import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';

class AddInAppNotificationsFilterUseCase {
  const AddInAppNotificationsFilterUseCase(this._liveEventsRepository);

  final LiveEventsRepository _liveEventsRepository;

  void execute(NotificationsFilter filter) => _liveEventsRepository.addNotificationsFilter(filter);
}
