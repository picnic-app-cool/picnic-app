import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_updated_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// This class is being used to store unread chats information and show them cross the app.
/// Storage is defined [UnreadCountersStore]
/// An instance of this class we can create from two places:
/// 1. Getting from getUnreadChats in GraphqlChatRepository
/// 2. Create from [ChatUpdatedEvent] in this case we do not contain lastMessageAtString
class UnreadChat extends Equatable {
  const UnreadChat({
    required this.chatId,
    required this.chatType,
    required this.lastMessageAtString,
    required this.unreadMessagesCount,
  });

  const UnreadChat.empty()
      : chatId = const Id.none(),
        chatType = ChatType.single,
        lastMessageAtString = "",
        unreadMessagesCount = 0;

  UnreadChat.fromChatUpdatedEvent(ChatUpdatedEvent event)
      : chatId = event.chatId,
        chatType = event.chatType,
        lastMessageAtString = "",
        unreadMessagesCount = event.unreadMessagesCount;

  final Id chatId;
  final ChatType chatType;
  final String lastMessageAtString;
  final int unreadMessagesCount;

  DateTime? get lastMessageAt => DateTime.tryParse(lastMessageAtString)?.toLocal();

  @override
  List<Object?> get props => [
        chatId,
        chatType,
        lastMessageAtString,
        unreadMessagesCount,
      ];

  UnreadChat copyWith({
    Id? chatId,
    ChatType? chatType,
    String? lastMessageAtString,
    int? unreadMessagesCount,
  }) {
    return UnreadChat(
      chatId: chatId ?? this.chatId,
      chatType: chatType ?? this.chatType,
      lastMessageAtString: lastMessageAtString ?? this.lastMessageAtString,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
    );
  }
}
