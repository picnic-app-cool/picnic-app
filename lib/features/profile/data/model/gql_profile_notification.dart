import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/data/model/gql_profile_notification_data.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_banned_from_app.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_banned_from_circle.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_circle.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_election_about_to_lose.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_election_someone_passed.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_follow.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_glitterbomb.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_comment.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_reaction.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_removed_moderator.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_removed_picnic.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_reported_moderator.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_saved.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_shared.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_seeds_received.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_unbanned_from_app.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_unbanned_from_circle.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_unknown.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_user.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_user_invited_to_circle.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_user_joined_circle.dart';

class GqlProfileNotification {
  const GqlProfileNotification({
    required this.id,
    required this.from,
    required this.receiver,
    required this.source,
    required this.subsource,
    required this.action,
    required this.imageUrl,
    required this.createdAt,
  });

  factory GqlProfileNotification.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlProfileNotification(
      id: asT<String>(json, 'id'),
      from: GqlProfileNotificationData.fromJson(asT<Map<String, dynamic>>(json, 'fromInfo')),
      receiver: GqlProfileNotificationData.fromJson(asT<Map<String, dynamic>>(json, 'receiverInfo')),
      source: GqlProfileNotificationData.fromJson(asT<Map<String, dynamic>>(json, 'sourceInfo')),
      subsource: GqlProfileNotificationData.fromJson(asT<Map<String, dynamic>>(json, 'subSourceInfo')),
      action: asT<String>(json, 'action'),
      createdAt: asT<String>(json, 'createdAt'),
      imageUrl: asT<String>(json, 'imageURL'),
    );
  }

  final String id;
  final GqlProfileNotificationData from;
  final GqlProfileNotificationData receiver;
  final GqlProfileNotificationData source;
  final GqlProfileNotificationData subsource;
  final String action;
  final String imageUrl;
  final String createdAt;

  //ignore: long-method
  ProfileNotification toDomain() {
    final type = NotificationType.fromString(action);
    switch (type) {
      case NotificationType.postComment:
        return ProfileNotificationPostComment(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          contentImageUrl: source.avatar,
          postId: Id(source.id),
        );
      case NotificationType.postReaction:
        return ProfileNotificationPostReaction(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          contentImageUrl: source.avatar,
          postId: Id(source.id),
        );
      case NotificationType.postShared:
        return ProfileNotificationPostShared(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          contentImageUrl: source.avatar,
          postId: Id(source.id),
        );
      case NotificationType.postSaved:
        return ProfileNotificationPostSaved(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          contentImageUrl: source.avatar,
          postId: Id(source.id),
        );
      case NotificationType.postReportedModerator:
        return ProfileNotificationPostReportedModerator(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          contentImageUrl: subsource.avatar,
          username: from.name,
          circleId: Id(source.id),
          circleName: source.name,
        );
      case NotificationType.glitterbomb:
        return ProfileNotificationGlitterbomb(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
        );
      case NotificationType.follow:
        return ProfileNotificationFollow(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          iFollow: from.relation,
          userId: Id(from.id),
        );
      case NotificationType.seedsReceived:
        return ProfileNotificationSeedsReceived(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleName: source.name,
        );
      case NotificationType.unbannedFromCircle:
        return ProfileNotificationUnbannedFromCircle(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleName: source.name,
          circleId: Id(source.id),
        );
      case NotificationType.bannedFromCircle:
        return ProfileNotificationBannedFromCircle(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleName: source.name,
          circleId: Id(source.id),
        );
      case NotificationType.bannedFromApp:
        return ProfileNotificationBannedFromApp(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
        );
      case NotificationType.unbannedFromApp:
        return ProfileNotificationUnbannedFromApp(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
        );
      case NotificationType.postRemovedModerator:
        return ProfileNotificationPostRemovedModerator(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleId: Id(source.id),
          circleName: source.name,
        );
      case NotificationType.postRemovedPicnic:
        return ProfileNotificationPostRemovedPicnic(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
        );
      case NotificationType.electionAboutToLose:
        return ProfileNotificationElectionAboutToLose(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleId: Id(source.id),
          circleName: source.name,
          username: from.name,
        );
      case NotificationType.electionSomeonePassed:
        return ProfileNotificationElectionSomeonePassed(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleId: Id(source.id),
          circleName: source.name,
          username: from.name,
        );
      case NotificationType.userJoinedACircle:
        return ProfileNotificationUserJoinedCircle(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleId: Id(source.id),
          circleName: source.name,
          username: from.name,
        );
      case NotificationType.userInvitedToACircle:
        return ProfileNotificationUserInvitedToCircle(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleId: Id(source.id),
          circleName: source.name,
          username: from.name,
          joined: from.relation,
        );

      case NotificationType.commentReaction:
      case NotificationType.messageReply:
      case NotificationType.message:
      case NotificationType.unknown:
        return ProfileNotificationUnknown(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
        );
      case NotificationType.circle:
        return ProfileNotificationCircle(
          id: Id(id),
          userAvatar: from.avatar,
          name: from.name,
          userId: Id(from.id),
          circleId: Id(source.id),
          circleName: source.name,
        );
      case NotificationType.post:
        return ProfileNotificationPost(
          id: Id(id),
          userId: Id(from.id),
          userAvatar: from.avatar,
          name: source.name,
          postId: Id(source.id),
        );
      case NotificationType.profile:
      case NotificationType.user:
        return ProfileNotificationUser(
          id: Id(id),
          userAvatar: source.avatar,
          name: source.name,
          userId: Id(source.id),
        );
    }
  }
}
