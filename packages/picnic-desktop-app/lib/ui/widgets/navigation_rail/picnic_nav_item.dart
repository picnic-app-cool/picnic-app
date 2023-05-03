import 'package:equatable/equatable.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicNavItem extends Equatable {
  const PicnicNavItem({
    required this.id,
    required this.icon,
    required this.activeIcon,
    this.label,
  });

  factory PicnicNavItem.feed() => PicnicNavItem(
        id: PicnicNavItemId.feed,
        icon: Assets.images.feedStroked.path,
        activeIcon: Assets.images.feedFilled.path,
        label: appLocalizations.feedTitle,
      );

  factory PicnicNavItem.chatFeed() => PicnicNavItem(
        id: PicnicNavItemId.feedChat,
        icon: Assets.images.chatStroked.path,
        activeIcon: Assets.images.chatFeed.path,
        label: appLocalizations.chatFeedTitle,
      );

  factory PicnicNavItem.chats() => PicnicNavItem(
        id: PicnicNavItemId.chats,
        icon: Assets.images.chats.path,
        activeIcon: Assets.images.chats.path,
        label: appLocalizations.chatsTitle,
      );

  final PicnicNavItemId id;
  final String icon;
  final String activeIcon;
  final String? label;

  @override
  List<Object?> get props => [
        id,
        icon,
        activeIcon,
        label,
      ];
}

enum PicnicNavItemId {
  feed,
  chats,
  feedChat;

  PicnicNavItem get picnicNavItem {
    switch (this) {
      case feed:
        return PicnicNavItem.feed();
      case chats:
        return PicnicNavItem.chats();
      case feedChat:
        return PicnicNavItem.chatFeed();
    }
  }
}
