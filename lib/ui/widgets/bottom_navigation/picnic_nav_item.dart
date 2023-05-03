import 'package:picnic_app/resources/assets.gen.dart';

//ignore_for_file: no-magic-number
enum PicnicNavItem {
  feed(
    0,
    'feed',
    showAsTab: true,
  ),
  add(
    1,
    'add',
    showAsTab: false,
  ),
  chat(
    2,
    'chat',
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

  String getIcon() {
    switch (this) {
      case PicnicNavItem.feed:
        return Assets.images.feedStroked.path;
      case PicnicNavItem.add:
        return Assets.images.add.path;
      case PicnicNavItem.chat:
        return Assets.images.chatStroked.path;
    }
  }

  String getActiveIcon() {
    switch (this) {
      case PicnicNavItem.feed:
        return Assets.images.feedFilled.path;
      case PicnicNavItem.add:
        return Assets.images.add.path;
      case PicnicNavItem.chat:
        return Assets.images.chatNavigationFilled.path;
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
