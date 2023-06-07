import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

enum PostShareApp {
  sms,
  snapchat,
  instagram,
  stories,
  telegram,
  messenger;

  String get name {
    switch (this) {
      case PostShareApp.sms:
        return appLocalizations.postShareAppSms;
      case PostShareApp.snapchat:
        return appLocalizations.postShareAppSnapchat;
      case PostShareApp.instagram:
        return appLocalizations.postShareAppInstagram;
      case PostShareApp.stories:
        return appLocalizations.postShareAppStories;
      case PostShareApp.telegram:
        return appLocalizations.postShareAppTelegram;
      case PostShareApp.messenger:
        return appLocalizations.postShareAppMessenger;
    }
  }

  String get asset {
    switch (this) {
      case PostShareApp.sms:
        return Assets.images.shareSms.path;
      case PostShareApp.snapchat:
        return Assets.images.shareSnapchat.path;
      case PostShareApp.instagram:
        return Assets.images.shareInstagram.path;
      case PostShareApp.stories:
        return Assets.images.shareStories.path;
      case PostShareApp.telegram:
        return Assets.images.shareTelegram.path;
      case PostShareApp.messenger:
        return Assets.images.shareMessenger.path;
    }
  }
}
