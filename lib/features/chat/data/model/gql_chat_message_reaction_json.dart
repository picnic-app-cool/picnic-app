import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';

class GqlChatMessageReactionJson {
  const GqlChatMessageReactionJson({
    required this.reaction,
    required this.hasReacted,
    required this.count,
  });

  factory GqlChatMessageReactionJson.fromJson(Map<String, dynamic>? json) => GqlChatMessageReactionJson(
        reaction: asT<String>(json, 'reaction'),
        hasReacted: asT<bool>(json, 'hasReacted'),
        count: asT<int>(json, 'count'),
      );

  final String reaction;
  final bool hasReacted;
  final int count;

  ChatMessageReaction toDomain() => ChatMessageReaction(
        reactionType: ChatMessageReactionType(reaction),
        hasReacted: hasReacted,
        count: count,
      );
}
