import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

//ignore: missing_empty_constructor
class ProfileNotificationUnbannedFromCircle extends Equatable implements ProfileNotification {
  const ProfileNotificationUnbannedFromCircle({
    required this.id,
    required this.userAvatar,
    required this.name,
    required this.userId,
    required this.circleName,
    required this.circleId,
  });

  final String circleName;
  final Id circleId;

  @override
  final Id id;
  @override
  final String userAvatar;
  @override
  final String name;
  @override
  final Id userId;
  @override
  NotificationType get type => NotificationType.unbannedFromCircle;

  @override
  List<Object?> get props => [
        id,
        userAvatar,
        name,
        userId,
        circleId,
        circleName,
      ];

  ProfileNotificationUnbannedFromCircle copyWith({
    Id? id,
    String? userAvatar,
    String? name,
    Id? userId,
    String? circleName,
    Id? circleId,
  }) {
    return ProfileNotificationUnbannedFromCircle(
      id: id ?? this.id,
      userAvatar: userAvatar ?? this.userAvatar,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      circleName: circleName ?? this.circleName,
      circleId: circleId ?? this.circleId,
    );
  }

  @override
  DeepLink toDeepLink() => DeepLink.circle(circleId: circleId);
}
