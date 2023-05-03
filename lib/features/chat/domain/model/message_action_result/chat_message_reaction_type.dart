import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/message_action_result.dart';

class ChatMessageReactionType extends Equatable implements MessageActionResult {
  const ChatMessageReactionType(this.value);

  factory ChatMessageReactionType.heart() => const ChatMessageReactionType('❤️');

  factory ChatMessageReactionType.thumbsUp() => const ChatMessageReactionType('👍');

  factory ChatMessageReactionType.thumbsDown() => const ChatMessageReactionType('👎');

  factory ChatMessageReactionType.fire() => const ChatMessageReactionType('🔥');

  factory ChatMessageReactionType.thinking() => const ChatMessageReactionType('🤔');

  factory ChatMessageReactionType.empty() => const ChatMessageReactionType('');

  final String value;

  static List<ChatMessageReactionType> get values => [
        ChatMessageReactionType.heart(),
        ChatMessageReactionType.thumbsUp(),
        ChatMessageReactionType.thumbsDown(),
        ChatMessageReactionType.fire(),
        ChatMessageReactionType.thinking(),
      ];

  @override
  List<Object?> get props => [value];

  @override
  MessageActionResultType get type => MessageActionResultType.chatMessageReaction;

  ChatMessageReactionType copyWith({String? value}) {
    return ChatMessageReactionType(value ?? this.value);
  }
}
