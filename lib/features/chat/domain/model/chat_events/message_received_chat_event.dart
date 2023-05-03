import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';

class MessageReceivedChatEvent extends Equatable implements ChatEvent {
  const MessageReceivedChatEvent({
    required this.message,
  });

  const MessageReceivedChatEvent.empty() : message = const ChatMessage.empty();

  final ChatMessage message;

  @override
  ChatEventType get type => ChatEventType.newMessageReceived;

  @override
  List<Object?> get props => [
        message,
      ];

  MessageReceivedChatEvent copyWith({
    ChatMessage? message,
  }) {
    return MessageReceivedChatEvent(
      message: message ?? this.message,
    );
  }
}
