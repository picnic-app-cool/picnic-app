import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class ProfileNotificationUserInvitedToCircle extends Equatable implements ProfileNotification {
  const ProfileNotificationUserInvitedToCircle({
    required this.id,
    required this.name,
    required this.userAvatar,
    required this.userId,
    required this.joined,
    required this.circleId,
    required this.circleName,
    required this.username,
  });

  final Id circleId;
  final String circleName;
  final String username;
  final bool joined;

  @override
  final Id id;

  @override
  final String name;

  @override
  final String userAvatar;

  @override
  final Id userId;

  @override
  NotificationType get type => NotificationType.userInvitedToACircle;

  @override
  List<Object?> get props => [
        id,
        name,
        joined,
        userAvatar,
        userId,
        circleId,
        circleName,
        username,
      ];

  @override
  DeepLink toDeepLink() => DeepLink.circle(circleId: circleId);

  ProfileNotificationUserInvitedToCircle copyWith({
    Id? circleId,
    String? circleName,
    String? username,
    bool? joined,
    Id? id,
    String? name,
    String? userAvatar,
    Id? userId,
  }) {
    return ProfileNotificationUserInvitedToCircle(
      circleId: circleId ?? this.circleId,
      circleName: circleName ?? this.circleName,
      username: username ?? this.username,
      joined: joined ?? this.joined,
      id: id ?? this.id,
      name: name ?? this.name,
      userAvatar: userAvatar ?? this.userAvatar,
      userId: userId ?? this.userId,
    );
  }
}
