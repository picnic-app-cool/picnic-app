import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';

class ChatMessageContentText extends StatelessWidget {
  const ChatMessageContentText({
    required this.displayableMessage,
    required this.chatStyle,
    this.onTapLink,
  });

  final DisplayableChatMessage displayableMessage;
  final PicnicChatStyle chatStyle;
  final void Function(String url)? onTapLink;

  @override
  Widget build(BuildContext context) {
    final contentText = displayableMessage.chatMessage.displayableContent;

    final textStyle =
        displayableMessage.chatMessage.isUserMessage ? chatStyle.userTextStyle : chatStyle.friendTextStyle;

    return Linkify(
      text: contentText,
      textAlign: TextAlign.left,
      style: textStyle,
      onOpen: (link) => onTapLink?.call(link.url),
      options: const LinkifyOptions(humanize: false),
      linkStyle: TextStyle(
        color: textStyle.color,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
