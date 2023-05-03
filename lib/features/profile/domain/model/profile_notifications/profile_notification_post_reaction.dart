import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class ProfileNotificationPostReaction extends Equatable implements ProfileNotification {
  const ProfileNotificationPostReaction({
    required this.id,
    required this.userAvatar,
    required this.name,
    required this.userId,
    required this.contentImageUrl,
    required this.postId,
  });

  final String contentImageUrl;
  final Id postId;

  @override
  final Id id;
  @override
  final String userAvatar;
  @override
  final String name;
  @override
  final Id userId;
  @override
  NotificationType get type => NotificationType.postReaction;

  @override
  List<Object?> get props => [
        id,
        userAvatar,
        name,
        userId,
        contentImageUrl,
        postId,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.post(postId: postId);
}
