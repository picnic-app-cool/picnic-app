import 'package:picnic_app/core/domain/model/notifications/notification_banned_from_app.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_banned_from_circle.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_circle.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_election_about_to_lose.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_election_someone_passed.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_follow.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_glitterbomb.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_message.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_comment.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_reaction.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_removed_moderator.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_removed_picnic.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_reported_moderator.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_saved.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_post_shared.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_seeds_received.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_unbanned_from_app.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_unbanned_from_circle.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_unknown.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_user.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_user_invited_to_circle.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_user_joined_circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

abstract class Notification {
  factory Notification.glitterbomb({
    required String message,
    required Id userId,
  }) =>
      NotificationGlitterbomb(
        message: message,
        userId: userId,
      );

  factory Notification.follow({
    required String message,
    required Id userId,
  }) =>
      NotificationFollow(
        message: message,
        userId: userId,
      );

  factory Notification.message({
    required String message,
    required Id chatId,
  }) =>
      NotificationMessage(
        message: message,
        chatId: chatId,
      );

  factory Notification.postComment({
    required String message,
    required Id postId,
  }) =>
      NotificationPostComment(
        message: message,
        postId: postId,
      );

  factory Notification.postReaction({
    required String message,
    required Id postId,
  }) =>
      NotificationPostReaction(
        message: message,
        postId: postId,
      );

  factory Notification.postReportedModerator({
    required String message,
    required Id circleId,
  }) =>
      NotificationPostReportedModerator(
        message: message,
        circleId: circleId,
      );

  factory Notification.postSaved({
    required String message,
    required Id postId,
  }) =>
      NotificationPostSaved(
        message: message,
        postId: postId,
      );

  factory Notification.postShared({
    required String message,
    required Id postId,
  }) =>
      NotificationPostShared(
        message: message,
        postId: postId,
      );

  factory Notification.seedsReceived({
    required String message,
  }) =>
      NotificationSeedsReceived(
        message: message,
      );

  factory Notification.bannedFromCircle({
    required String message,
  }) =>
      NotificationBannedFromCircle(
        message: message,
      );

  factory Notification.unbannedFromCircle({
    required String message,
    required Id circleId,
  }) =>
      NotificationUnbannedFromCircle(
        message: message,
        circleId: circleId,
      );

  factory Notification.bannedFromApp({
    required String message,
  }) =>
      NotificationBannedFromApp(
        message: message,
      );

  factory Notification.unbannedFromApp({
    required String message,
  }) =>
      NotificationUnbannedFromApp(
        message: message,
      );

  factory Notification.general({
    required String message,
  }) =>
      NotificationUnknown(
        message: message,
      );

  factory Notification.postRemovedModerator({
    required String message,
    required Id circleId,
  }) =>
      NotificationPostRemovedModerator(
        message: message,
        circleId: circleId,
      );

  factory Notification.circle({
    required String message,
    required Id circleId,
  }) =>
      NotificationCircle(
        message: message,
        circleId: circleId,
      );

  factory Notification.user({
    required String message,
    required Id userId,
  }) =>
      NotificationUser(
        message: message,
        userId: userId,
      );

  factory Notification.post({
    required String message,
    required Id postId,
  }) =>
      NotificationPost(
        message: message,
        postId: postId,
      );

  factory Notification.postRemovedPicnic({
    required String message,
  }) =>
      NotificationPostRemovedPicnic(
        message: message,
      );

  factory Notification.electionAboutToLose({
    required Id circleId,
    required String message,
  }) =>
      NotificationElectionAboutToLose(
        circleId: circleId,
        message: message,
      );

  factory Notification.electionSomeonePassed({
    required Id circleId,
    required String message,
  }) =>
      NotificationElectionSomeonePassed(
        circleId: circleId,
        message: message,
      );

  factory Notification.userJoinedCircle({
    required Id circleId,
    required String message,
  }) =>
      NotificationUserJoinedCircle(
        circleId: circleId,
        message: message,
      );

  factory Notification.userInvitedToCircle({
    required Id circleId,
    required String message,
  }) =>
      NotificationUserInvitedToCircle(
        circleId: circleId,
        message: message,
      );

  String get message;

  NotificationType get type;

  DeepLink toDeepLink();
}
