import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_profile.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class NotificationGlitterbomb extends Equatable implements Notification {
  const NotificationGlitterbomb({
    required this.message,
    required this.userId,
  });

  final Id userId;

  @override
  final String message;

  @override
  NotificationType get type => NotificationType.glitterbomb;

  @override
  List<Object?> get props => [
        message,
        userId,
      ];

  @override
  DeepLink toDeepLink() => const DeepLinkProfile.empty().copyWith(userId: userId);
}
