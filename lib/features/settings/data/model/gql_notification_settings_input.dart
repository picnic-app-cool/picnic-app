import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';

extension GqlNotificationSettingsInput on NotificationSettings {
  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId.value,
      'likes': likes,
      'comments': comments,
      'newFollowers': newFollowers,
      'mentions': mentions,
      'directMessages': directMessages,
      'postsFromAccountsYouFollow': postsFromAccountsYouFollow,
      'circleChats': circleChats,
      'groupChats': groupChats,
      'commentLikes': commentLikes,
      'glitterBombs': glitterBombs,
      'postSaves': postSaves,
      'postShares': postShares,
      'seeds': seeds,
      'circleJoins': circleJoins,
      'circleInvites': circleInvites,
    };
  }
}
