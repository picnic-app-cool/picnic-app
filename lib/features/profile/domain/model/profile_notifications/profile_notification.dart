import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_banned_from_app.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_banned_from_circle.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_circle.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_election_about_to_lose.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_election_someone_passed.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_follow.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_glitterbomb.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_message.dart';
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

abstract class ProfileNotification {
  Id get id;

  Id get userId;

  String get userAvatar;

  String get name;

  NotificationType get type;

  DeepLink toDeepLink();
}

extension ProfileNotificationWhen on ProfileNotification {
  // ignore: long-parameter-list, long-method
  T when<T>({
    required T Function(ProfileNotificationGlitterbomb notification) onGlitterbomb,
    required T Function(ProfileNotificationFollow notification) onFollow,
    required T Function(ProfileNotificationMessage notification) onMessage,
    required T Function(ProfileNotificationPostComment notification) onPostComment,
    required T Function(ProfileNotificationPostReaction notification) onPostReaction,
    required T Function(ProfileNotificationSeedsReceived notification) onSeedsReceived,
    required T Function(ProfileNotificationPostShared notification) onPostShared,
    required T Function(ProfileNotificationPostSaved notification) onPostSaved,
    required T Function(ProfileNotificationPostReportedModerator notification) onPostReportedModerator,
    required T Function(ProfileNotificationBannedFromCircle notification) onBannedFromCircle,
    required T Function(ProfileNotificationUnbannedFromCircle notification) onUnbannedFromCircle,
    required T Function(ProfileNotificationBannedFromApp notification) onBannedFromApp,
    required T Function(ProfileNotificationUnbannedFromApp notification) onUnbannedFromApp,
    required T Function(ProfileNotificationPostRemovedModerator notification) onPostRemovedModerator,
    required T Function(ProfileNotificationPostRemovedPicnic notification) onPostRemovedPicnic,
    required T Function(ProfileNotificationUnknown notification) onUnknown,
    required T Function(ProfileNotificationElectionAboutToLose notification) onElectionAboutToLoose,
    required T Function(ProfileNotificationElectionSomeonePassed notification) onElectionSomeonePassed,
    required T Function(ProfileNotificationUserJoinedCircle notification) onUserJoinedCircle,
    required T Function(ProfileNotificationUserInvitedToCircle notification) onUserInvitedToCircle,
    required T Function(ProfileNotificationCircle notification) onCircle,
    required T Function(ProfileNotificationPost notification) onPost,
    required T Function(ProfileNotificationUser notification) onUser,
  }) {
    switch (type) {
      case NotificationType.glitterbomb:
        return onGlitterbomb(this as ProfileNotificationGlitterbomb);
      case NotificationType.follow:
        return onFollow(this as ProfileNotificationFollow);
      case NotificationType.message:
        return onMessage(this as ProfileNotificationMessage);
      case NotificationType.postComment:
        return onPostComment(this as ProfileNotificationPostComment);
      case NotificationType.seedsReceived:
        return onSeedsReceived(this as ProfileNotificationSeedsReceived);
      case NotificationType.postReaction:
        return onPostReaction(this as ProfileNotificationPostReaction);
      case NotificationType.postShared:
        return onPostShared(this as ProfileNotificationPostShared);
      case NotificationType.postSaved:
        return onPostSaved(this as ProfileNotificationPostSaved);
      case NotificationType.postReportedModerator:
        return onPostReportedModerator(this as ProfileNotificationPostReportedModerator);
      case NotificationType.bannedFromCircle:
        return onBannedFromCircle(this as ProfileNotificationBannedFromCircle);
      case NotificationType.unbannedFromCircle:
        return onUnbannedFromCircle(this as ProfileNotificationUnbannedFromCircle);
      case NotificationType.bannedFromApp:
        return onBannedFromApp(this as ProfileNotificationBannedFromApp);
      case NotificationType.unbannedFromApp:
        return onUnbannedFromApp(this as ProfileNotificationUnbannedFromApp);
      case NotificationType.postRemovedModerator:
        return onPostRemovedModerator(this as ProfileNotificationPostRemovedModerator);
      case NotificationType.postRemovedPicnic:
        return onPostRemovedPicnic(this as ProfileNotificationPostRemovedPicnic);
      case NotificationType.electionAboutToLose:
        return onElectionAboutToLoose(this as ProfileNotificationElectionAboutToLose);
      case NotificationType.electionSomeonePassed:
        return onElectionSomeonePassed(this as ProfileNotificationElectionSomeonePassed);
      case NotificationType.userJoinedACircle:
        return onUserJoinedCircle(this as ProfileNotificationUserJoinedCircle);
      case NotificationType.userInvitedToACircle:
        return onUserInvitedToCircle(this as ProfileNotificationUserInvitedToCircle);
      case NotificationType.commentReaction:
      case NotificationType.messageReply:
      case NotificationType.unknown:
        return onUnknown(this as ProfileNotificationUnknown);
      case NotificationType.circle:
        return onCircle(this as ProfileNotificationCircle);
      case NotificationType.post:
        return onPost(this as ProfileNotificationPost);
      case NotificationType.profile:
      case NotificationType.user:
        return onUser(this as ProfileNotificationUser);
    }
  }
}
