import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class ProfileNotificationPostRemovedPicnic extends Equatable implements ProfileNotification {
  const ProfileNotificationPostRemovedPicnic({
    required this.id,
    required this.userAvatar,
    required this.name,
    required this.userId,
  });

  @override
  final Id id;
  @override
  final String userAvatar;
  @override
  final String name;
  @override
  final Id userId;
  @override
  NotificationType get type => NotificationType.postRemovedPicnic;

  @override
  List<Object?> get props => [
        id,
        userAvatar,
        name,
        userId,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.general();
}
