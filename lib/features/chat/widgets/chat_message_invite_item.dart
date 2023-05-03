import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_invite_card.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_card.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_text.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';

class ChatMessageInviteItem extends StatelessWidget {
  const ChatMessageInviteItem({
    required this.displayableMessage,
    required this.chatStyle,
    required this.onTapJoinCircle,
    required this.onTapCircleDetails,
    super.key,
  });

  final DisplayableChatMessage displayableMessage;
  final PicnicChatStyle chatStyle;
  final ValueChanged<ChatMessage> onTapJoinCircle;
  final ValueChanged<ChatMessage> onTapCircleDetails;

  static const _textContentPadding = EdgeInsets.all(10);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ChatMessageContentCard(
          displayableMessage: displayableMessage,
          chatStyle: chatStyle,
          child: Padding(
            padding: _textContentPadding,
            child: ChatMessageContentText(
              displayableMessage: displayableMessage,
              chatStyle: chatStyle,
            ),
          ),
        ),
        const Gap(4),
        ChatInviteCard(
          isSameUser: true,
          message: displayableMessage.chatMessage,
          onTapJoinCircle: onTapJoinCircle,
          onTapCircleDetails: onTapCircleDetails,
        ),
      ],
    );
  }
}
