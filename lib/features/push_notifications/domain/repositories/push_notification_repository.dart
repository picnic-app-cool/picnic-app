import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/features/push_notifications/domain/model/get_push_notification_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/model/update_device_token_failure.dart';

abstract class PushNotificationRepository {
  Stream<Notification> get pushNotificationOpenedApp;

  Future<Either<UpdateDeviceTokenFailure, Unit>> sendDeviceTokenToBackend({
    required String token,
  });

  Future<Either<GetPushNotificationTokenFailure, String>> getDeviceToken();

  void setDeviceTokenUpdateListener(DeviceTokenListenerCallback? callback);

  Future<void> clearToken();
}

typedef DeviceTokenListenerCallback = void Function(String);
