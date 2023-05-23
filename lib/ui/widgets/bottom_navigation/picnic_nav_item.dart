import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/resources/assets.gen.dart';

//ignore_for_file: no-magic-number
enum PicnicNavItem {
  feed(
    0,
    'feed',
    showAsTab: true,
  ),
  discover(
    1,
    'add',
    showAsTab: true,
  ),
  add(
    2,
    'add',
    showAsTab: false,
  ),
  chat(
    3,
    'chat',
    showAsTab: true,
  ),
  profile(
    4,
    'profile',
    showAsTab: true,
  );

  final int position;

  final String value;

  /// determines whether nav item should be shown as tab (and be part of PageView) or not
  final bool showAsTab;

  const PicnicNavItem(
    this.position,
    this.value, {
    required this.showAsTab,
  });

  String getIcon(PostOverlayTheme overlayTheme) {
    switch (this) {
      case PicnicNavItem.feed:
        return Assets.images.feedStroked.path;
      case PicnicNavItem.add:
        return overlayTheme == PostOverlayTheme.light ? Assets.images.plusPost.path : Assets.images.plusPostGrey.path;
      case PicnicNavItem.chat:
        return overlayTheme == PostOverlayTheme.light
            ? Assets.images.chatNavigationOutlinedWhite.path
            : Assets.images.chatNavigationOutlinedBlack.path;
      case PicnicNavItem.discover:
        return overlayTheme == PostOverlayTheme.light
            ? Assets.images.discoverOutlinedWhite.path
            : Assets.images.discoverOutlinedBlack.path;
      case PicnicNavItem.profile:
        return Assets.images.contact.path;
    }
  }

  String getActiveIcon(PostOverlayTheme overlayTheme) {
    switch (this) {
      case PicnicNavItem.feed:
        return Assets.images.feedFilled.path;
      case PicnicNavItem.add:
        return overlayTheme == PostOverlayTheme.light ? Assets.images.plusPost.path : Assets.images.plusPostGrey.path;
      case PicnicNavItem.chat:
        return Assets.images.chatNavigationFilledBlack.path;
      case PicnicNavItem.discover:
        return Assets.images.discoverFilled.path;
      case PicnicNavItem.profile:
        return Assets.images.contact.path;
    }
  }
}

extension TabsIteration on PicnicNavItem {
  PicnicNavItem? previousTab(List<PicnicNavItem> items) {
    var index = items.indexOf(this) - 1;
    while (index >= 0 && !items[index].showAsTab) {
      index--;
    }
    return index != -1 ? items[index] : null;
  }

  PicnicNavItem? nextTab(List<PicnicNavItem> items) {
    var index = items.indexOf(this) + 1;
    while (index < items.length && !items[index].showAsTab) {
      index++;
    }
    return index < items.length ? items[index] : null;
  }
}
