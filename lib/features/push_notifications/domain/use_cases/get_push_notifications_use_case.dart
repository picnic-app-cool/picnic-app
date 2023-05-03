import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';

class GetPushNotificationsUseCase {
  const GetPushNotificationsUseCase(this._pushNotificationRepository);

  final PushNotificationRepository _pushNotificationRepository;

  Stream<Notification> execute() {
    return _pushNotificationRepository.pushNotificationOpenedApp;
  }
}
