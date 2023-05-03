import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

enum CircleTab {
  posts,
  preview,
  royalty,
  members,
  rules,
  slices;

  String get icon {
    switch (this) {
      case posts:
        return Assets.images.image.path;
      case preview:
        return Assets.images.category.path;
      case royalty:
        return Assets.images.heart.path;
      case rules:
        return Assets.images.folder.path;
      case slices:
        return Assets.images.pieChart.path;
      case CircleTab.members:
        return Assets.images.tusers.path;
    }
  }

  String get label {
    switch (this) {
      case posts:
        return appLocalizations.postsTabTitle;
      case preview:
        return appLocalizations.previewTabTitle;
      case royalty:
        return appLocalizations.royaltyTabTitle;
      case rules:
        return appLocalizations.rulesTabTitle;
      case slices:
        return appLocalizations.slices;
      case CircleTab.members:
        return appLocalizations.membersLabel;
    }
  }
}
