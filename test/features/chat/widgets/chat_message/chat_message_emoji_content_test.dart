import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_emoji_content.dart';

import '../../../../test_utils/golden_tests_utils.dart';

void main() {
  final input = {
    'one emoji': '😀',
    'one emoji with space': '😀 ',
    'three emojis wits spaces in between': '😀 😀 😀',
    'four emojis with spaces': '  😀 😀😀😀 ',
    'text with emoji at the end': 'text😀',
    'text with emoji at the beginning': '😀text',
    'text with emoji in the middle': 'text😀text',
  };

  widgetScreenshotTest(
    "chat_message_emoji_content",
    widgetBuilder: (context) => GoldenTestGroup(
      children: input.entries.map(
        (entry) {
          final name = entry.key;
          final content = entry.value;
          final chatMessage = const ChatMessage.empty().copyWith(content: content);
          return GoldenTestScenario(
            name: name,
            child: TestWidgetContainer(
              child: ChatMessageEmojiContent(chatMessage: chatMessage),
            ),
          );
        },
      ).toList(),
    ),
  );
}
