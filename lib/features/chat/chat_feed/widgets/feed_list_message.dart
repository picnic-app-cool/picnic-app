import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeedListMessage extends StatelessWidget {
  const FeedListMessage({
    Key? key,
    required this.displayableMessage,
  }) : super(key: key);

  final DisplayableChatMessage displayableMessage;

  static const _topAvatarSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final avatarColor = colors.teal;

    final avatarBorderColor = colors.purple;

    final message = displayableMessage.chatMessage;

    final chatStyle = PicnicChatStyle.fromContext(
      context,
      ChatType.circle,
    );

    MainAxisAlignment mainAxisAlignment;
    var borderImage = const ImageUrl.empty();
    Color? borderColor;
    switch (message.chatMessageSender) {
      case ChatMessageSender.user:
        mainAxisAlignment = MainAxisAlignment.end;
        borderImage = ImageUrl(Assets.images.watermelonSkin.path);
        break;
      case ChatMessageSender.friend:
        mainAxisAlignment = MainAxisAlignment.start;
        borderColor = avatarBorderColor;
    }

    final picnicAvatar = PicnicAvatar(
      borderImage: borderImage,
      boxFit: PicnicAvatarChildBoxFit.cover,
      size: _topAvatarSize,
      backgroundColor: avatarColor,
      borderColor: borderColor,
      imageSource: PicnicImageSource.url(
        message.author.profileImageUrl,
        fit: BoxFit.cover,
        width: _topAvatarSize,
        height: _topAvatarSize,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (message.chatMessageSender == ChatMessageSender.friend) ...[
            if (!message.isComponentType) picnicAvatar,
            const Gap(10),
          ] else if (message.chatMessageSender == ChatMessageSender.user) ...[
            const Gap(30),
          ],
          Flexible(
            child: ChatMessageContent(
              displayableMessage: displayableMessage,
              chatMessageContentActions: ChatMessageContentActions.empty(),
              chatStyle: chatStyle,
            ),
          ),
        ],
      ),
    );
  }
}
