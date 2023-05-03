import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class ProfileNotificationUserJoinedCircle extends Equatable implements ProfileNotification {
  const ProfileNotificationUserJoinedCircle({
    required this.id,
    required this.name,
    required this.userAvatar,
    required this.userId,
    required this.circleId,
    required this.circleName,
    required this.username,
  });

  final Id circleId;
  final String circleName;
  final String username;

  @override
  final Id id;

  @override
  final String name;

  @override
  final String userAvatar;

  @override
  final Id userId;

  @override
  NotificationType get type => NotificationType.userJoinedACircle;

  @override
  List<Object?> get props => [
        id,
        name,
        userAvatar,
        userId,
        circleId,
        circleName,
        username,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.circle(circleId: circleId);
}
