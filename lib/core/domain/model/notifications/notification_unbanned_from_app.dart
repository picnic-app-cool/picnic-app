import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class NotificationUnbannedFromApp extends Equatable implements Notification {
  const NotificationUnbannedFromApp({
    required this.message,
  });

  @override
  final String message;

  @override
  NotificationType get type => NotificationType.unbannedFromApp;

  @override
  List<Object?> get props => [
        message,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.general();
}
