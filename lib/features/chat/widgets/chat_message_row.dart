import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/circle_chat/widgets/circle_mod_avatar.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/widgets/message_not_sent.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';

class ChatMessageRow extends StatelessWidget {
  const ChatMessageRow({
    Key? key,
    required this.isContinuationMessage,
    this.isAuthorModerator = false,
    required this.message,
    required this.avatarBorderColor,
    required this.picnicMessage,
    required this.onTapFriendAvatar,
    required this.onTapOwnAvatar,
  }) : super(key: key);

  final bool isContinuationMessage;
  final bool isAuthorModerator;
  final ChatMessage message;
  final Color? avatarBorderColor;
  final Widget picnicMessage;
  final VoidCallback onTapFriendAvatar;
  final VoidCallback onTapOwnAvatar;

  static const _avatarSize = 32.0;
  static const _pendingMessageOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
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

    Widget picnicAvatar = InkWell(
      onTap: message.chatMessageSender == ChatMessageSender.friend ? onTapFriendAvatar : onTapOwnAvatar,
      child: PicnicAvatar(
        borderImage: borderImage,
        boxFit: PicnicAvatarChildBoxFit.cover,
        size: _avatarSize,
        backgroundColor: PicnicColors.borderBlue,
        borderColor: borderColor,
        imageSource: PicnicImageSource.url(
          fit: BoxFit.cover,
          message.author.profileImageUrl,
          width: _avatarSize,
          height: _avatarSize,
        ),
      ),
    );

    if (isAuthorModerator) {
      picnicAvatar = CircleModAvatar(
        child: picnicAvatar,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (isContinuationMessage) ...[
          const Gap(40),
        ] else if (message.chatMessageSender == ChatMessageSender.friend) ...[
          if (!message.isComponentType || message.isComponentPost) picnicAvatar,
          const Gap(10),
        ] else if (message.chatMessageSender == ChatMessageSender.user) ...[
          const Gap(30),
        ],
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Opacity(
                opacity: message.isPending && !message.isNotSent ? _pendingMessageOpacity : 1,
                child: picnicMessage,
              ),
              if (message.isNotSent) MessageNotSent.short(),
            ],
          ),
        ),
      ],
    );
  }
}
