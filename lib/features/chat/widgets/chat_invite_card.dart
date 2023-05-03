import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/chat_circle_invite.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message_card.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ChatInviteCard extends StatelessWidget {
  const ChatInviteCard({
    required this.message,
    required this.isSameUser,
    required this.onTapJoinCircle,
    required this.onTapCircleDetails,
    super.key,
  });

  final ChatMessage message;
  final bool isSameUser;
  final ValueChanged<ChatMessage> onTapJoinCircle;
  final ValueChanged<ChatMessage> onTapCircleDetails;

  @override
  Widget build(BuildContext context) {
    const avatarSize = 64.0;

    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    const buttonBorderWidth = 2.0;
    final greenColor = colors.green.shade500;

    final circle = (message.component!.payload as ChatCircleInvite).circle;
    final circleName = circle.name;
    final membersCount = circle.membersCount.toString();
    final circleAvatar = circle.emoji;
    final isJoined = circle.iJoined;

    VoidCallback? onTapButton;
    final String buttonTitle;
    final PicnicButtonStyle buttonStyle;
    final double borderWidth;
    final Color borderColor;
    final Color titleColor;
    if (isJoined) {
      buttonTitle = appLocalizations.joinedButtonActionTitle;
      buttonStyle = PicnicButtonStyle.outlined;
      borderWidth = buttonBorderWidth;
      borderColor = greenColor;
      titleColor = greenColor;
    } else {
      onTapButton = () => onTapJoinCircle(message);
      buttonTitle = appLocalizations.joinButtonActionTitle;
      buttonStyle = PicnicButtonStyle.filled;
      borderWidth = 0;
      borderColor = Colors.transparent;
      titleColor = Colors.white;
    }

    return ChatMessageCard(
      message: message,
      isSameUser: isSameUser,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      onTap: () => onTapCircleDetails(message),
      child: Row(
        children: [
          PicnicAvatar(
            imageSource: PicnicImageSource.url(
              ImageUrl(circleAvatar),
            ),
            backgroundColor: colors.green.shade200,
            size: avatarSize,
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  circleName,
                  style: styles.title20,
                ),
                const Gap(2),
                Text(
                  '$membersCount ${appLocalizations.membersLabel}',
                  style: styles.caption10.copyWith(
                    color: colors.blackAndWhite.shade600,
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    Flexible(
                      child: PicnicButton(
                        title: buttonTitle,
                        onTap: onTapButton,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        minWidth: double.infinity,
                        style: buttonStyle,
                        borderWidth: borderWidth,
                        borderColor: borderColor,
                        titleColor: titleColor,
                        opacity: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
