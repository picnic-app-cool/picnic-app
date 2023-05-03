import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

enum GroupChatMoreTab {
  settings,
  members;

  String get label {
    switch (this) {
      case settings:
        return appLocalizations.settingsLabel;
      case members:
        return appLocalizations.membersLabel;
    }
  }

  String get icon {
    switch (this) {
      case settings:
        return Assets.images.setting.path;
      case members:
        return Assets.images.tusers.path;
    }
  }
}
