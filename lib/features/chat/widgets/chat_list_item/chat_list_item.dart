import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item/chat_list_item_displayable.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item_avatar.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/badged_title.dart';
import 'package:picnic_app/ui/widgets/unread_counter_badge.dart';
import 'package:picnic_app/utils/extensions/date_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.model,
    required this.now,
    this.onTapChat,
    this.circle,
  }) : super(key: key);

  final Function(BasicChat)? onTapChat;
  final ChatListItemDisplayable model;
  final BasicCircle? circle;

  final DateTime now;

  static const double _badgeSize = 20;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final titleTextStyle = theme.styles.subtitle30;
    final subTitleTextStyle = theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600);

    final chat = model.chat;
    final badgeCount = chat.unreadMessagesCount;
    final showBadge = (chat.chatType != ChatType.circle) && badgeCount > 0;

    final latestMessage = chat.latestMessage;
    final subTitle = latestMessage.displayableContent;
    final always24Format = MediaQuery.of(context).alwaysUse24HourFormat;
    final timeAgo = latestMessage.createdAt?.timeAgo(now, always24Format: always24Format) ?? '';
    final listItemAvatar = (type) {
      switch (type) {
        case ChatType.single:
          return ChatListItemAvatar.single(imageUrl: chat.image);
        case ChatType.group:
          return ChatListItemAvatar.group();
        case ChatType.circle:
          return ChatListItemAvatar.circle(circle: circle, placeholder: chat.image);
      }
    }(chat.chatType)!;

    return InkWell(
      onTap: () => onTapChat?.call(chat),
      child: Row(
        children: [
          listItemAvatar,
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BadgedTitle(
                  model: model.title,
                  style: titleTextStyle,
                ),
                Text(
                  subTitle,
                  style: subTitleTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                timeAgo,
                style: subTitleTextStyle,
              ),
              if (showBadge)
                UnreadCounterBadge(
                  count: badgeCount,
                  color: colors.blue,
                  size: _badgeSize,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
