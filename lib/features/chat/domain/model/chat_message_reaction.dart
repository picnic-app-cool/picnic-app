import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';

class ChatMessageReaction extends Equatable {
  const ChatMessageReaction({
    required this.reactionType,
    required this.hasReacted,
    required this.count,
  });

  const ChatMessageReaction.empty()
      : reactionType = const ChatMessageReactionType(''),
        hasReacted = false,
        count = 0;

  final ChatMessageReactionType reactionType;
  final bool hasReacted;
  final int count;

  @override
  List<Object?> get props => [
        reactionType,
        hasReacted,
        count,
      ];

  ChatMessageReaction copyWith({
    ChatMessageReactionType? reactionType,
    bool? hasReacted,
    int? count,
  }) {
    return ChatMessageReaction(
      reactionType: reactionType ?? this.reactionType,
      hasReacted: hasReacted ?? this.hasReacted,
      count: count ?? this.count,
    );
  }
}
