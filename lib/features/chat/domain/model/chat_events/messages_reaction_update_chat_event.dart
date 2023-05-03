import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';

class MessagesReactionUpdateChatEvent extends Equatable implements ChatEvent {
  const MessagesReactionUpdateChatEvent({
    required this.messageId,
    required this.reactionType,
    required this.count,
  });

  const MessagesReactionUpdateChatEvent.empty()
      : messageId = const Id.empty(),
        reactionType = const ChatMessageReactionType(''),
        count = 0;

  final Id messageId;
  final ChatMessageReactionType reactionType;
  final int count;

  @override
  ChatEventType get type => ChatEventType.messageReactionUpdated;

  @override
  List<Object?> get props => [
        messageId,
        reactionType,
        count,
      ];

  MessagesReactionUpdateChatEvent copyWith({
    Id? messageId,
    ChatMessageReactionType? reactionType,
    int? count,
  }) {
    return MessagesReactionUpdateChatEvent(
      messageId: messageId ?? this.messageId,
      reactionType: reactionType ?? this.reactionType,
      count: count ?? this.count,
    );
  }
}
