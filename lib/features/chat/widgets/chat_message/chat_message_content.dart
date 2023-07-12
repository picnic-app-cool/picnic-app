import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/chat_circle_invite.dart';
import 'package:picnic_app/features/chat/domain/model/chat_glitter_bomb.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_post_payload.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/embed_status.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_attachments.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_card.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_link_preview.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_post.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_reply.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_text.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_emoji_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_pdf_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_reactions_panel.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/features/chat/widgets/chat_message_glitter_bomb_item.dart';
import 'package:picnic_app/features/chat/widgets/chat_message_invite_item.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/badged_title.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';
import 'package:picnic_app/utils/extensions/string_extensions.dart';

class ChatMessageContent extends StatelessWidget {
  const ChatMessageContent({
    required this.displayableMessage,
    required this.chatMessageContentActions,
    required this.chatStyle,
    this.isAuthorModerator = false,
  });

  final DisplayableChatMessage displayableMessage;
  final ChatMessageContentActions chatMessageContentActions;
  final PicnicChatStyle chatStyle;
  final bool isAuthorModerator;

  static const _contentPadding = EdgeInsets.only(
    left: 10,
    right: 10,
    bottom: 10,
  );

  static const _horizontalPadding = EdgeInsets.symmetric(horizontal: 10);

  ChatMessage get _chatMessage => displayableMessage.chatMessage;

  @override
  Widget build(BuildContext context) {
    switch (_chatMessage.chatMessageType) {
      case ChatMessageType.text:
        String? authorText;
        if (displayableMessage.showAuthor && _chatMessage.chatMessageSender == ChatMessageSender.friend) {
          authorText = _chatMessage.authorFormattedUsername;
        }
        if (_chatMessage.content.hasOnlyEmojis()) {
          return ChatMessageEmojiContent(chatMessage: _chatMessage);
        }

        if (_chatMessage.hasPdf) {
          return ChatMessagePdfContent(
            displayableMessage: displayableMessage,
            chatStyle: chatStyle,
            onTap: chatMessageContentActions.onTapPdf,
          );
        }

        return ChatMessageContentCard(
          displayableMessage: displayableMessage,
          chatStyle: chatStyle,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_chatMessage.repliedContent != null) ...[
                const Gap(10),
                Padding(
                  padding: _horizontalPadding,
                  child: ChatMessageContentReply(
                    message: _chatMessage,
                    chatStyle: chatStyle,
                    onTapUnblur: chatMessageContentActions.onTapUnblurAttachment,
                  ),
                ),
              ],
              if (authorText != null) ...[
                const Gap(10),
                InkWell(
                  onTap: () => chatMessageContentActions.onTapFriendProfile(_chatMessage.authorId),
                  child: Padding(
                    padding: _horizontalPadding,
                    child: BadgedTitle(
                      model: _chatMessage.author.toBadgedAuthorDisplayable().byAddingBadges([
                        if (isAuthorModerator) AchievementBadgeType.moderator,
                      ]),
                      style: chatStyle.authorStyle,
                    ),
                  ),
                ),
              ],
              if (_chatMessage.attachments.isNotEmpty) ...[
                if (authorText != null) const Gap(1) else if (_chatMessage.repliedContent != null) const Gap(10),
                ChatMessageContentAttachments(
                  message: _chatMessage,
                  chatStyle: chatStyle,
                  onTapUnblur: chatMessageContentActions.onTapUnblurAttachment,
                  onTapAttachment: () => chatMessageContentActions.onTapAttachment(_chatMessage),
                ),
              ],
              if (displayableMessage.chatMessage.content.isNotEmpty) ...[
                if (_chatMessage.attachments.isNotEmpty)
                  const Gap(6)
                else if (authorText != null)
                  const Gap(1)
                else
                  const Gap(10),
                Padding(
                  padding: _contentPadding,
                  child: ChatMessageContentText(
                    displayableMessage: displayableMessage,
                    chatStyle: chatStyle,
                    onTapLink: chatMessageContentActions.onTapLink,
                  ),
                ),
                if (_chatMessage.embeds.isNotEmpty)
                  for (final embed in _chatMessage.embeds)
                    if (embed.status == EmbedStatus.success) ...[
                      const Gap(10),
                      Padding(
                        padding: _horizontalPadding,
                        child: ChatMessageContentLinkPreview(
                          embed: embed,
                          onTap: chatMessageContentActions.onTapLink,
                          chatStyle: chatStyle,
                        ),
                      ),
                      const Gap(10),
                    ],
              ],
              if (_chatMessage.hasAnyReactions) ...[
                Padding(
                  padding: _horizontalPadding,
                  child: ChatMessageReactionsPanel(
                    reactions: _chatMessage.reactions,
                    isUserMessage: _chatMessage.isUserMessage,
                  ),
                ),
                const Gap(10),
              ],
            ],
          ),
        );
      case ChatMessageType.component:
        return _chatMessage.component!.payload.when(
          circleInvite: (ChatCircleInvite content) {
            return ChatMessageInviteItem(
              displayableMessage: displayableMessage,
              chatStyle: chatStyle,
              onTapJoinCircle: chatMessageContentActions.onTapJoinCircle,
              onTapCircleDetails: chatMessageContentActions.onTapCircleDetails,
            );
          },
          glitterBomb: (ChatGlitterBomb content) {
            return ChatMessageGlitterBombItem(displayableMessage: displayableMessage, chatStyle: chatStyle);
          },
          post: (ChatMessagePostPayload content) {
            return ChatMessageContentPost(
              post: content.post,
              onTap: () => chatMessageContentActions.onTapPost(content.post, displayableMessage.chatMessage),
              displayableMessage: displayableMessage,
              chatStyle: chatStyle,
            );
          },
          unknownContent: () {
            return const SizedBox.shrink();
          },
        );
    }
  }
}
