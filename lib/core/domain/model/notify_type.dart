import 'package:picnic_app/localization/app_localizations_utils.dart';

enum NotifyType {
  inviteCircle(value: 'INVITE_CIRCLE'),
  sharePost(value: 'SHARE_POST'),
  inviteFriend(value: 'INVITE_FRIEND'),
  addFriend(value: 'ADD_FRIEND'),
  inviteChat(value: 'INVITE_CHAT');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case NotifyType.inviteCircle:
        return appLocalizations.inviteCircle;
      case NotifyType.sharePost:
        return appLocalizations.sharePost;
      case NotifyType.inviteFriend:
        return appLocalizations.inviteFriend;
      case NotifyType.addFriend:
        return appLocalizations.addFriend;
      case NotifyType.inviteChat:
        return appLocalizations.inviteChat;
    }
  }

  const NotifyType({required this.value});

  static List<NotifyType> get allRoles => [
        inviteCircle,
        sharePost,
        inviteFriend,
        addFriend,
        inviteChat,
      ];

  static NotifyType fromString(String value) => NotifyType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => NotifyType.inviteCircle,
      );

  String toJson() {
    return value;
  }
}
