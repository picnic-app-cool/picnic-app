import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class MessageDeletedChatEvent extends Equatable implements ChatEvent {
  const MessageDeletedChatEvent({
    required this.chatId,
    required this.messageId,
  });

  const MessageDeletedChatEvent.empty()
      : chatId = const Id.empty(),
        messageId = const Id.empty();

  final Id chatId;
  final Id messageId;

  @override
  ChatEventType get type => ChatEventType.messageDeleted;

  @override
  List<Object?> get props => [
        chatId,
        messageId,
      ];

  MessageDeletedChatEvent copyWith({
    Id? chatId,
    Id? messageId,
  }) {
    return MessageDeletedChatEvent(
      chatId: chatId ?? this.chatId,
      messageId: messageId ?? this.messageId,
    );
  }
}
