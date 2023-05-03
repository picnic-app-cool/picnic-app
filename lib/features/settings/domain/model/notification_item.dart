import 'package:picnic_app/localization/app_localizations_utils.dart';

enum NotificationItem {
  likes('likes'),
  comments('comments'),
  commentLikes('comment_likes'),
  postSaves('post_saves'),
  postShares('posts_shares'),
  glitterBombs('glitter_bombs'),
  newFollowers('new_followers'),
  mentions('mentions'),

  directMessages('direct_messages'),
  postsFromAccountsYouFollow('posts_from_accounts_you_follow'),

  circleChats('circle_chats'),
  groupChats('group_chats'),
  seeds('seeds'),
  circleJoins('circle_joins'),
  circleInvites('circle_invites');

  final String value;

  const NotificationItem(this.value);

  //ignore: long-method
  String get label {
    switch (this) {
      case NotificationItem.likes:
        return appLocalizations.likesNotificationAction;
      case NotificationItem.comments:
        return appLocalizations.commentsNotificationAction;
      case NotificationItem.commentLikes:
        return appLocalizations.commentsLikesNotificationAction;
      case NotificationItem.postSaves:
        return appLocalizations.savesPostsNotificationsAction;
      case NotificationItem.postShares:
        return appLocalizations.sharesPostsNotificationsAction;
      case NotificationItem.glitterBombs:
        return appLocalizations.glitterbombNotificationsActions;
      case NotificationItem.newFollowers:
        return appLocalizations.newFollowersNotificationAction;
      case NotificationItem.mentions:
        return appLocalizations.mentionsNotificationAction;
      case NotificationItem.directMessages:
        return appLocalizations.directMessagesNotificationAction;
      case NotificationItem.postsFromAccountsYouFollow:
        return appLocalizations.postFromAccountsYouFollowNotificationAction;
      case NotificationItem.circleChats:
        return appLocalizations.circleChatsNotificationAction;
      case NotificationItem.groupChats:
        return appLocalizations.groupChatsNotificationAction;
      case NotificationItem.seeds:
        return appLocalizations.seedsNotificationsAction;
      case NotificationItem.circleJoins:
        return appLocalizations.circleJoinsNotificationAction;
      case NotificationItem.circleInvites:
        return appLocalizations.circleInvitesNotificationAction;
    }
  }
}
