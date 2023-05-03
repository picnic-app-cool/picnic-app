import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_reactions_panel.dart';
import 'package:picnic_app/utils/extensions/string_extensions.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

// ignore_for_file: no-magic-number
class ChatMessageEmojiContent extends StatelessWidget {
  const ChatMessageEmojiContent({required this.chatMessage, super.key});

  final ChatMessage chatMessage;

  static const _contentPadding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    final white = PicnicTheme.of(context).colors.blackAndWhite.shade100;
    final content = chatMessage.content;
    return Container(
      color: white, // Non-transparent color prevents emojis to be cut off from the bottom
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          Text(
            content,
            style: TextStyle(fontSize: _getFontSize(content.countEmojis())),
          ),
          if (chatMessage.hasAnyReactions) ...[
            const Gap(10),
            Padding(
              padding: _contentPadding,
              child: ChatMessageReactionsPanel(
                reactions: chatMessage.reactions,
                isUserMessage: chatMessage.isUserMessage,
              ),
            ),
          ],
        ],
      ),
    );
  }

  double _getFontSize(int count) {
    switch (count) {
      case 1:
        return 56;
      case 2:
        return 48;
      case 3:
        return 40;
      case 4:
      case 5:
        return 32;
      default:
        return 24;
    }
  }
}
