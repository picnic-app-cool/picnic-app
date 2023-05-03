import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/ui/widgets/picnic_blurred_image.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessageContentReply extends StatelessWidget {
  const ChatMessageContentReply({
    required this.message,
    required this.chatStyle,
    required this.onTapUnblur,
  });

  final ChatMessage message;
  final PicnicChatStyle chatStyle;
  final Function(Attachment) onTapUnblur;

  static const _borderRadius = 16.0;
  static const _repliedUserNameOpacity = .6;
  static const _repliedImageSize = 32.0;
  static const _repliedShowIconSize = _repliedImageSize / 5;

  static const _contentPadding = EdgeInsets.only(
    left: 8,
    right: 8,
  );

  ChatMessage get repliedMessage => message.repliedContent!;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleCaption10 = theme.styles.caption10;
    final textStyleBody10 = theme.styles.body10;

    Color backgroundColor;
    Color backgroundLeftColor;
    Color textColor;

    switch (message.chatMessageSender) {
      case ChatMessageSender.user:
        backgroundColor = chatStyle.userReplyBackgroundColor;
        backgroundLeftColor = chatStyle.userReplyBackgroundLeftColor;
        textColor = chatStyle.userReplyTextColor;
        break;
      case ChatMessageSender.friend:
        backgroundColor = chatStyle.friendReplyBackgroundColor;
        backgroundLeftColor = chatStyle.friendReplyBackgroundLeftColor;
        textColor = chatStyle.friendReplyTextColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 2.5,
      ),
      decoration: BoxDecoration(
        color: backgroundLeftColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            _borderRadius,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              _borderRadius,
            ),
          ),
        ),
        child: Padding(
          padding: _contentPadding,
          child: Row(
            children: [
              if (repliedMessage.attachments.isNotEmpty) ...[
                () {
                  final attachment = repliedMessage.attachments.first;

                  return SizedBox(
                    width: _repliedImageSize,
                    height: _repliedImageSize,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: PicnicBlurredImage(
                        imageUrl: attachment.thumbnailUrl,
                        isBlurred: attachment.isBlurred,
                        onTapUnblur: () => onTapUnblur(attachment),
                        showIconSize: _repliedShowIconSize,
                      ),
                    ),
                  );
                }(),
                const Gap(4),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(4),
                    Text(
                      repliedMessage.authorFormattedUsername,
                      style: textStyleBody10.copyWith(
                        color: textColor.withOpacity(_repliedUserNameOpacity),
                      ),
                    ),
                    if (repliedMessage.content.isNotEmpty) ...[
                      Text(
                        repliedMessage.content,
                        style: textStyleCaption10.copyWith(
                          color: textColor,
                        ),
                      ),
                      const Gap(4),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
