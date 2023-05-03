import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class ProfileNotificationPost extends Equatable implements ProfileNotification {
  const ProfileNotificationPost({
    required this.id,
    required this.userId,
    required this.name,
    required this.postId,
    required this.userAvatar,
  });

  final Id postId;

  @override
  final Id id;
  @override
  final Id userId;
  @override
  final String name;
  @override
  final String userAvatar;

  @override
  NotificationType get type => NotificationType.post;

  @override
  List<Object?> get props => [
        id,
        userAvatar,
        name,
        userId,
        postId,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.post(postId: postId);
}
