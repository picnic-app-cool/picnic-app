import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/settings/domain/model/notification_item.dart';

class NotificationSettings extends Equatable {
  const NotificationSettings({
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

  const NotificationSettings.empty()
      : notificationId = const Id.empty(),
        likes = false,
        comments = false,
        newFollowers = false,
        mentions = false,
        directMessages = false,
        postsFromAccountsYouFollow = false,
        circleChats = false,
        groupChats = false,
        commentLikes = false,
        glitterBombs = false,
        postShares = false,
        postSaves = false,
        seeds = false,
        circleJoins = false,
        circleInvites = false;

  final Id notificationId;
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

  @override
  List<Object?> get props => [
        notificationId,
        likes,
        comments,
        newFollowers,
        mentions,
        directMessages,
        postsFromAccountsYouFollow,
        circleChats,
        groupChats,
        commentLikes,
        glitterBombs,
        postShares,
        postSaves,
        seeds,
        circleJoins,
        circleInvites,
      ];

  NotificationSettings copyWith({
    Id? notificationId,
    bool? likes,
    bool? comments,
    bool? newFollowers,
    bool? mentions,
    bool? directMessages,
    bool? postsFromAccountsYouFollow,
    bool? circleChats,
    bool? groupChats,
    bool? commentLikes,
    bool? glitterBombs,
    bool? postShares,
    bool? postSaves,
    bool? seeds,
    bool? circleJoins,
    bool? circleInvites,
  }) {
    return NotificationSettings(
      notificationId: notificationId ?? this.notificationId,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      newFollowers: newFollowers ?? this.newFollowers,
      mentions: mentions ?? this.mentions,
      directMessages: directMessages ?? this.directMessages,
      postsFromAccountsYouFollow: postsFromAccountsYouFollow ?? this.postsFromAccountsYouFollow,
      circleChats: circleChats ?? this.circleChats,
      groupChats: groupChats ?? this.groupChats,
      commentLikes: commentLikes ?? this.commentLikes,
      glitterBombs: glitterBombs ?? this.glitterBombs,
      postShares: postShares ?? this.postShares,
      postSaves: postSaves ?? this.postSaves,
      seeds: seeds ?? this.seeds,
      circleJoins: circleJoins ?? this.circleJoins,
      circleInvites: circleInvites ?? this.circleInvites,
    );
  }
}

extension NotificationSettingsItem on NotificationSettings {
  //ignore: long-method
  bool settingForItem(NotificationItem notificationItem) {
    switch (notificationItem) {
      case NotificationItem.likes:
        return likes;
      case NotificationItem.comments:
        return comments;
      case NotificationItem.newFollowers:
        return newFollowers;
      case NotificationItem.mentions:
        return mentions;
      case NotificationItem.directMessages:
        return directMessages;
      case NotificationItem.postsFromAccountsYouFollow:
        return postsFromAccountsYouFollow;
      case NotificationItem.circleChats:
        return circleChats;
      case NotificationItem.groupChats:
        return groupChats;
      case NotificationItem.commentLikes:
        return commentLikes;
      case NotificationItem.glitterBombs:
        return glitterBombs;
      case NotificationItem.postShares:
        return postShares;
      case NotificationItem.postSaves:
        return postSaves;
      case NotificationItem.seeds:
        return seeds;
      case NotificationItem.circleJoins:
        return circleJoins;
      case NotificationItem.circleInvites:
        return circleInvites;
    }
  }

  //ignore: long-method
  NotificationSettings copyAndToggleItem(NotificationItem notificationItem) {
    switch (notificationItem) {
      case NotificationItem.likes:
        return copyWith(likes: !likes);
      case NotificationItem.comments:
        return copyWith(comments: !comments);
      case NotificationItem.newFollowers:
        return copyWith(newFollowers: !newFollowers);
      case NotificationItem.mentions:
        return copyWith(mentions: !mentions);
      case NotificationItem.directMessages:
        return copyWith(directMessages: !directMessages);
      case NotificationItem.postsFromAccountsYouFollow:
        return copyWith(postsFromAccountsYouFollow: !postsFromAccountsYouFollow);
      case NotificationItem.circleChats:
        return copyWith(circleChats: !circleChats);
      case NotificationItem.groupChats:
        return copyWith(groupChats: !groupChats);
      case NotificationItem.commentLikes:
        return copyWith(commentLikes: !commentLikes);
      case NotificationItem.glitterBombs:
        return copyWith(glitterBombs: !glitterBombs);
      case NotificationItem.postShares:
        return copyWith(postShares: !postShares);
      case NotificationItem.postSaves:
        return copyWith(postSaves: !postSaves);
      case NotificationItem.seeds:
        return copyWith(seeds: !seeds);
      case NotificationItem.circleJoins:
        return copyWith(circleJoins: !circleJoins);
      case NotificationItem.circleInvites:
        return copyWith(circleInvites: !circleInvites);
    }
  }
}
