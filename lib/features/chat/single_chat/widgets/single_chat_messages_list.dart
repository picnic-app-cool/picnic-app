import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/single_chat/widgets/single_chat_row.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_messages_list/chat_messages_list.dart';

class SingleChatMessagesList extends StatelessWidget {
  const SingleChatMessagesList({
    required this.messages,
    required this.loadMore,
    required this.now,
    required this.onTapFriendAvatar,
    required this.onTapOwnAvatar,
    required this.chatMessageContentActions,
    required this.dragOffset,
    super.key,
  });

  final PaginatedList<DisplayableChatMessage> messages;
  final Future<void> Function() loadMore;
  final DateTime now;
  final VoidCallback onTapFriendAvatar;
  final VoidCallback onTapOwnAvatar;
  final ChatMessageContentActions chatMessageContentActions;
  final double dragOffset;

  static const _paddingSingleChatContent = EdgeInsets.only(
    left: Constants.smallPadding,
    top: 16,
    right: Constants.smallPadding,
    bottom: 25,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ChatMessagesList(
            messages: messages,
            loadMore: loadMore,
            now: now,
            padding: _paddingSingleChatContent,
            itemBuilder: (context, displayableMessage) {
              return SingleChatRow(
                isContinuationMessage: !displayableMessage.isFirstInGroup,
                isLastItem: displayableMessage.isLastInGroup,
                displayableMessage: displayableMessage,
                now: now,
                onTapFriendAvatar: onTapFriendAvatar,
                onTapOwnAvatar: onTapOwnAvatar,
                chatMessageContentActions: chatMessageContentActions,
                dragOffset: dragOffset,
              );
            },
          ),
        ),
      ],
    );
  }
}
