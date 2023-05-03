import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/feed_list_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';

class NonScrollableFeedListMessage extends StatelessWidget {
  const NonScrollableFeedListMessage({
    Key? key,
    required this.chatMessages,
  }) : super(key: key);

  final List<ChatMessage> chatMessages;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      children: chatMessages
          .map(
            (it) => FeedListMessage(
              displayableMessage: DisplayableChatMessage(
                chatMessage: it,
                isFirstInGroup: true,
                isLastInGroup: true,
                showAuthor: true,
                previousMessage: const ChatMessage.empty(),
              ),
            ),
          )
          .toList(),
    );
  }
}
