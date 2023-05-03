import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_card.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_reactions_panel.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessagePdfContent extends StatelessWidget {
  const ChatMessagePdfContent({
    required this.displayableMessage,
    required this.chatStyle,
    required this.onTap,
    super.key,
  });

  final DisplayableChatMessage displayableMessage;
  final PicnicChatStyle chatStyle;
  final ValueChanged<Attachment> onTap;

  static const _contentPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 6);

  @override
  Widget build(BuildContext context) {
    final chatMessage = displayableMessage.chatMessage;
    final attachment = chatMessage.attachments.first;
    final colors = PicnicTheme.of(context).colors;
    final grey = colors.blackAndWhite.shade200;

    return GestureDetector(
      onTap: () => onTap(attachment),
      child: ChatMessageContentCard(
        displayableMessage: displayableMessage,
        chatStyle: chatStyle,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: grey,
                    ),
                    child: Image.asset(
                      Assets.images.paper.path,
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attachment.pdfName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        Text('${attachment.sizeMB} MB'),
                      ],
                    ),
                  ),
                ],
              ),
              if (chatMessage.hasAnyReactions) ...[
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
        ),
      ),
    );
  }
}
