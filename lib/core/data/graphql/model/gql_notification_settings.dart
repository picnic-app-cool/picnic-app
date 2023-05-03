import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';

class GqlNotificationSettings {
  GqlNotificationSettings({
    required this.notificationId,
    required this.likes,
    required this.comments,
    required this.newFollowers,
    required this.mentions,
    required this.directMessages,
    required this.postsFromAccountsYouFollow,
    required this.circleChats,
    required this.groupChats,
    required this.commentLikes,
    required this.glitterBombs,
    required this.postShares,
    required this.postSaves,
    required this.seeds,
    required this.circleJoins,
    required this.circleInvites,
  });

  factory GqlNotificationSettings.fromJson(Map<String, dynamic> json) => GqlNotificationSettings(
        notificationId: asT<String>(json, 'notificationId'),
        likes: asT<bool>(json, 'likes'),
        comments: asT<bool>(json, 'comments'),
        newFollowers: asT<bool>(json, 'newFollowers'),
        mentions: asT<bool>(json, 'mentions'),
        directMessages: asT<bool>(json, 'directMessages'),
        postsFromAccountsYouFollow: asT<bool>(json, 'postsFromAccountsYouFollow'),
        circleChats: asT<bool>(json, 'circleChats'),
        groupChats: asT<bool>(json, 'groupChats'),
        commentLikes: asT<bool>(json, 'commentLikes'),
        glitterBombs: asT<bool>(json, 'glitterBombs'),
        postShares: asT<bool>(json, 'postShares'),
        postSaves: asT<bool>(json, 'postSaves'),
        seeds: asT<bool>(json, 'seeds'),
        circleJoins: asT<bool>(json, 'circleJoins'),
        circleInvites: asT<bool>(json, 'circleInvites'),
      );

  final String notificationId;
  final bool likes;
  final bool comments;
  final bool newFollowers;
  final bool mentions;
  final bool directMessages;
  final bool postsFromAccountsYouFollow;
  final bool circleChats;
  final bool groupChats;
  final bool commentLikes;
  final bool glitterBombs;
  final bool postShares;
  final bool postSaves;
  final bool seeds;
  final bool circleJoins;
  final bool circleInvites;

  NotificationSettings toDomain() => NotificationSettings(
        notificationId: Id(notificationId),
        likes: likes,
        comments: comments,
        newFollowers: newFollowers,
        mentions: mentions,
        directMessages: directMessages,
        postsFromAccountsYouFollow: postsFromAccountsYouFollow,
        circleChats: circleChats,
        groupChats: groupChats,
        commentLikes: commentLikes,
        glitterBombs: glitterBombs,
        postShares: postShares,
        postSaves: postSaves,
        seeds: seeds,
        circleJoins: circleJoins,
        circleInvites: circleInvites,
      );
}
