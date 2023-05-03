import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';

class MessageUpdatedChatEvent extends Equatable implements ChatEvent {
  const MessageUpdatedChatEvent({
    required this.message,
  });

  const MessageUpdatedChatEvent.empty() : message = const ChatMessage.empty();

  final ChatMessage message;

  @override
  ChatEventType get type => ChatEventType.messageUpdated;

  @override
  List<Object?> get props => [
        message,
      ];

  MessageUpdatedChatEvent copyWith({
    ChatMessage? message,
  }) {
    return MessageUpdatedChatEvent(
      message: message ?? this.message,
    );
  }
}
