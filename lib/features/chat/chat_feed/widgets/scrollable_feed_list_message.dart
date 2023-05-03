import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/feed_list_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ScrollableFeedListMessage extends StatefulWidget {
  const ScrollableFeedListMessage({
    Key? key,
    required this.chatMessages,
    this.messageIdToScrollTo,
  }) : super(key: key);

  final List<ChatMessage> chatMessages;
  final Id? messageIdToScrollTo;

  @override
  State<ScrollableFeedListMessage> createState() => _ScrollableFeedListMessageState();
}

class _ScrollableFeedListMessageState extends State<ScrollableFeedListMessage> {
  GlobalKey<State>? selectedMessageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSpecificMessage());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.chatMessages
            .map(
              (chatMessage) => FeedListMessage(
                key: (widget.messageIdToScrollTo == chatMessage.id) ? selectedMessageKey : null,
                displayableMessage: DisplayableChatMessage(
                  chatMessage: chatMessage,
                  isFirstInGroup: true,
                  isLastInGroup: true,
                  showAuthor: true,
                  previousMessage: const ChatMessage.empty(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    selectedMessageKey = null;
    super.dispose();
  }

  void _scrollToSpecificMessage() {
    final itemContext = selectedMessageKey?.currentContext;
    if (itemContext != null && widget.messageIdToScrollTo != null) {
      Scrollable.ensureVisible(
        itemContext,
        duration: const LongDuration(),
        curve: Curves.easeOutCirc,
      );
    }
  }
}
