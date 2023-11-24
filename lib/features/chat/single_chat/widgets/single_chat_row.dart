import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_clickable.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/features/chat/widgets/chat_message_row.dart';
import 'package:picnic_app/features/chat/widgets/message_timestamp.dart';
import 'package:picnic_app/ui/widgets/swipeable_left.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';

///[SingleChatRow] is the row in a chat body that holds the avatar and text
///
class SingleChatRow extends StatelessWidget {
  const SingleChatRow({
    required this.displayableMessage,
    required this.isContinuationMessage,
    required this.isLastItem,
    required this.now,
    required this.onTapFriendAvatar,
    required this.onTapOwnAvatar,
    required this.chatMessageContentActions,
    required this.dragOffset,
    super.key,
  });

  final DisplayableChatMessage displayableMessage;
  final bool isContinuationMessage;
  final bool isLastItem;
  final OnTapFriendAvatar onTapFriendAvatar;
  final VoidCallback onTapOwnAvatar;
  final DateTime now;
  final ChatMessageContentActions chatMessageContentActions;
  final double dragOffset;

  ChatMessage get message => displayableMessage.chatMessage;

  ChatMessage? get previousMessage => displayableMessage.previousMessage;

  EdgeInsets get _paddingBetweenMessageRows =>
      isLastItem ? const EdgeInsets.only(bottom: 12.0) : const EdgeInsets.only(bottom: 4.0);

  @override
  Widget build(BuildContext context) {
    final picnicMessage = ChatMessageContentClickable(
      displayableMessage: displayableMessage,
      chatMessageContentActions: chatMessageContentActions,
      chatStyle: PicnicChatStyle.fromContext(
        context,
        ChatType.single,
      ),
    );

    return Padding(
      padding: _paddingBetweenMessageRows,
      child: Column(
        children: [
          SwipeableLeft(
            offset: dragOffset,
            hiddenChild: MessageTimestamp(
              dateTime: message.createdAt,
            ),
            child: ChatMessageRow(
              picnicMessage: picnicMessage,
              avatarBorderColor: PicnicColors.borderBlue,
              isContinuationMessage: isContinuationMessage,
              message: message,
              onTapFriendAvatar: onTapFriendAvatar,
              onTapOwnAvatar: onTapOwnAvatar,
            ),
          ),
        ],
      ),
    );
  }
}
