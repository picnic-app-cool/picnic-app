import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatUpdatedEvent extends Equatable implements ChatEvent {
  const ChatUpdatedEvent({
    required this.chatId,
    required this.chatType,
    required this.unreadMessagesCount,
  });

  const ChatUpdatedEvent.empty()
      : chatId = const Id.empty(),
        chatType = ChatType.single,
        unreadMessagesCount = 0;

  final Id chatId;
  final ChatType chatType;
  final int unreadMessagesCount;

  @override
  List<Object?> get props => [
        chatId,
        chatType,
        unreadMessagesCount,
      ];

  @override
  ChatEventType get type => ChatEventType.chatUpdated;

  ChatUpdatedEvent copyWith({
    Id? chatId,
    ChatType? chatType,
    int? unreadMessagesCount,
  }) {
    return ChatUpdatedEvent(
      chatId: chatId ?? this.chatId,
      chatType: chatType ?? this.chatType,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
    );
  }
}
