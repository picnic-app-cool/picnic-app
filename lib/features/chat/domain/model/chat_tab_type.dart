// ignore_for_file: no-magic-number
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

enum ChatTabType {
  feed._(0, 'feed'),
  myCircles._(1, 'my_circles'),
  dms._(2, 'dms');

  final int stackIndex;
  final String value;

  String get label {
    switch (this) {
      case ChatTabType.feed:
        return appLocalizations.chatTabFeed;
      case ChatTabType.myCircles:
        return appLocalizations.chatTabCircles;
      case ChatTabType.dms:
        return appLocalizations.chatTabDms;
    }
  }

  String get iconKey {
    switch (this) {
      case ChatTabType.feed:
        return Assets.images.chatFeed.keyName;
      case ChatTabType.myCircles:
        return Assets.images.tusers.keyName;
      case ChatTabType.dms:
        return Assets.images.profileFilled.keyName;
    }
  }

  const ChatTabType._(this.stackIndex, this.value);

  static ChatTabType fromInt(int index) => ChatTabType.values.firstWhere(
        (it) => it.stackIndex == index,
        orElse: () => ChatTabType.feed,
      );
}
