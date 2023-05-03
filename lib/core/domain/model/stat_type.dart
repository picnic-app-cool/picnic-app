import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

enum StatType {
  posts,
  views,
  members,
  likes,
  followers,
  slices,
  none;

  String get title {
    switch (this) {
      case StatType.posts:
        return appLocalizations.postsTabTitle;
      case StatType.views:
        return appLocalizations.views;
      case StatType.members:
        return appLocalizations.membersLabel;
      case StatType.likes:
        return appLocalizations.likes;
      case StatType.followers:
        return appLocalizations.followers;
      case StatType.slices:
        return appLocalizations.slices;
      case StatType.none:
        return '';
    }
  }

  String get emoji {
    switch (this) {
      case StatType.posts:
        return '';
      case StatType.views:
        return '';
      case StatType.members:
        return '';
      case StatType.likes:
        return Constants.heartEmoji;
      case StatType.followers:
        return Constants.hugEmoji;
      case StatType.slices:
        return Constants.emojiWaterMelon;
      case StatType.none:
        return '';
    }
  }
}
