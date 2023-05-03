import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class NotificationPayload {
  const NotificationPayload({
    required this.fromId,
    required this.fromType,
    required this.title,
    required this.message,
    required this.sourceId,
    required this.sourceType,
    required this.subSourceId,
    required this.subSourceType,
    required this.type,
  });

  factory NotificationPayload.fromJson(Map<String, dynamic>? json) => NotificationPayload(
        fromId: asT<String>(json, 'fromId'),
        fromType: asT<int>(json, 'fromType'),
        title: asT<String>(json, 'title'),
        message: asT<String>(json, 'message'),
        sourceId: asT<String>(json, 'sourceId'),
        sourceType: asT<int>(json, 'sourceType'),
        subSourceId: asT<String>(json, 'subSourceId'),
        subSourceType: asT<int>(json, 'subSourceType'),
        type: asT<String>(json, 'action'),
      );

  final String fromId;
  final int fromType;
  final String title;
  final String message;
  final String sourceId;
  final int sourceType;
  final String subSourceId;
  final int subSourceType;
  final String type;

  // ignore: long-method
  Notification toNotification() {
    final notificationType = NotificationType.fromString(type);
    switch (notificationType) {
      case NotificationType.glitterbomb:
        return Notification.glitterbomb(
          message: message,
          userId: Id(fromId),
        );
      case NotificationType.follow:
        return Notification.follow(
          message: message,
          userId: Id(fromId),
        );
      case NotificationType.message:
        return Notification.message(
          message: message,
          chatId: Id(subSourceId),
        );
      case NotificationType.postComment:
        return Notification.postComment(
          message: message,
          postId: Id(sourceId),
        );
      case NotificationType.postReaction:
        return Notification.postReaction(
          message: message,
          postId: Id(sourceId),
        );
      case NotificationType.postShared:
        return Notification.postShared(
          message: message,
          postId: Id(sourceId),
        );
      case NotificationType.postSaved:
        return Notification.postSaved(
          message: message,
          postId: Id(sourceId),
        );
      case NotificationType.postReportedModerator:
        return Notification.postReportedModerator(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.seedsReceived:
        return Notification.seedsReceived(
          message: message,
        );
      case NotificationType.bannedFromCircle:
        return Notification.bannedFromCircle(
          message: message,
        );
      case NotificationType.unbannedFromCircle:
        return Notification.unbannedFromCircle(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.bannedFromApp:
        return Notification.bannedFromApp(
          message: message,
        );
      case NotificationType.unbannedFromApp:
        return Notification.unbannedFromApp(
          message: message,
        );
      case NotificationType.postRemovedModerator:
        return Notification.postRemovedModerator(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.postRemovedPicnic:
        return Notification.postRemovedPicnic(
          message: message,
        );
      case NotificationType.electionAboutToLose:
        return Notification.electionAboutToLose(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.electionSomeonePassed:
        return Notification.electionSomeonePassed(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.userJoinedACircle:
        return Notification.userJoinedCircle(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.userInvitedToACircle:
        return Notification.userInvitedToCircle(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.commentReaction:
      case NotificationType.messageReply:
      case NotificationType.unknown:
        return Notification.general(message: message);
      case NotificationType.circle:
        return Notification.circle(
          message: message,
          circleId: Id(sourceId),
        );
      case NotificationType.post:
        return Notification.post(
          message: message,
          postId: Id(sourceId),
        );
      case NotificationType.profile:
      case NotificationType.user:
        return Notification.user(
          message: message,
          userId: Id(sourceId),
        );
    }
  }
}
