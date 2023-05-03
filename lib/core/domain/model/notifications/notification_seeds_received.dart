import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class NotificationSeedsReceived extends Equatable implements Notification {
  const NotificationSeedsReceived({
    required this.message,
  });

  @override
  final String message;

  @override
  NotificationType get type => NotificationType.seedsReceived;

  @override
  List<Object?> get props => [
        message,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.userSeeds();
}
