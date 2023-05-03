import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_page.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_page.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';

class ChatTabContainer extends StatelessWidget {
  const ChatTabContainer({
    Key? key,
    required this.initialChatTabType,
    required this.chatFeedPage,
    required this.chatMyCirclesPage,
    required this.chatDmsPage,
    this.onPageChanged,
    this.pageController,
  }) : super(key: key);

  final ChatTabType initialChatTabType;
  final ChatFeedPage chatFeedPage;
  final Widget chatMyCirclesPage;
  final ChatDmsPage chatDmsPage;
  final ValueChanged<ChatTabType>? onPageChanged;
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      onPageChanged: _onPageChanged,
      controller: pageController,
      itemBuilder: (context, index) {
        final chatTabType = ChatTabType.fromInt(index % ChatTabType.values.length);
        switch (chatTabType) {
          case ChatTabType.feed:
            return chatFeedPage;
          case ChatTabType.myCircles:
            return chatMyCirclesPage;
          case ChatTabType.dms:
            return chatDmsPage;
        }
      },
      itemCount: ChatTabType.values.length,
    );
  }

  void _onPageChanged(int index) {
    final chatTabType = ChatTabType.fromInt(index % ChatTabType.values.length);
    onPageChanged?.call(chatTabType);
  }
}
