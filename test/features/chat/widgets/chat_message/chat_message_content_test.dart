import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_card.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_emoji_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';

import '../../../../test_extensions/widget_tester_extensions.dart';

void main() {
  group('ChatMessageContent', () {
    ChatMessageContent getChatMessageContent({required String content}) {
      final chatMessage = const ChatMessage.empty().copyWith(content: content);
      final displayableMessage = const DisplayableChatMessage.empty().copyWith(chatMessage: chatMessage);
      return ChatMessageContent(
        displayableMessage: displayableMessage,
        chatMessageContentActions: ChatMessageContentActions.empty(),
        chatStyle: PicnicChatStyle.forTesting(),
      );
    }

    testWidgets('shows ChatMessageEmojiContent when there are ONLY emojis', (tester) async {
      final chatMessageContent = getChatMessageContent(content: '😀');
      await tester.setupWidget(chatMessageContent);

      final chatMessageEmojiContent = find.byType(ChatMessageEmojiContent);

      expect(chatMessageEmojiContent, findsOneWidget);
    });

    testWidgets('shows ChatMessageContentCard when there are NO emojis', (tester) async {
      final chatMessageContent = getChatMessageContent(content: 'text');
      await tester.setupWidget(chatMessageContent);

      final chatMessageContentCard = find.byType(ChatMessageContentCard);

      expect(chatMessageContentCard, findsOneWidget);
    });
  });
}
