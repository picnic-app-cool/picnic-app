import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item_avatar.dart';
import 'package:picnic_app/features/posts/domain/model/share_recommendation_displayable.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/badged_title.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ShareRecommendationItem extends StatelessWidget {
  const ShareRecommendationItem({
    Key? key,
    required this.item,
    required this.onSendPressed,
  }) : super(key: key);

  final ShareRecommendationDisplayable item;
  final ValueChanged<BasicChat> onSendPressed;
  static const _borderButtonWidth = 1.0;
  static const _buttonInnerPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 12);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final titleStyle = theme.styles.subtitle30.copyWith(
      color: theme.colors.darkBlue.shade900,
    );
    final subtitleStyle = theme.styles.caption10.copyWith(
      color: theme.colors.darkBlue.shade600,
    );
    final buttonTitleStyle = theme.styles.link10;

    final whiteColor = theme.colors.blackAndWhite.shade100;
    final buttonColor = theme.colors.blue.shade500;
    final darkBlueColor = theme.colors.darkBlue;
    final buttonOutlinedColor = darkBlueColor.shade400;

    final chat = item.chatDisplayable.chat;
    final circle = item.chatDisplayable.circle;

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

    final membersText = chat.participantsCount < 10
        ? appLocalizations.membersCount(chat.participantsCount)
        : "${chat.participantsCount.formattingToStat()} ${appLocalizations.membersLabel}";

    return Row(
      children: [
        listItemAvatar,
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BadgedTitle(
                model: item.chatDisplayable.title,
                style: titleStyle,
              ),
              Text(
                membersText,
                style: subtitleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Gap(8),
        if (item.isSent)
          PicnicButton(
            title: appLocalizations.sentAction,
            titleStyle: buttonTitleStyle.copyWith(color: darkBlueColor.shade700),
            style: PicnicButtonStyle.outlined,
            borderColor: buttonOutlinedColor,
            borderWidth: _borderButtonWidth,
            padding: _buttonInnerPadding,
          )
        else
          PicnicButton(
            title: appLocalizations.sendAction,
            titleStyle: buttonTitleStyle.copyWith(color: whiteColor),
            onTap: () => onSendPressed(chat),
            color: buttonColor,
            padding: _buttonInnerPadding,
          ),
      ],
    );
  }
}
