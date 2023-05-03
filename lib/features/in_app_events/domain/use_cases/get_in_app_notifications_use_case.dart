import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';

class GetInAppNotificationsUseCase {
  const GetInAppNotificationsUseCase(this._liveEventsRepository);

  final LiveEventsRepository _liveEventsRepository;

  Future<Stream<Notification>> execute() async {
    return _liveEventsRepository.getInAppNotificationEvents();
  }
}
