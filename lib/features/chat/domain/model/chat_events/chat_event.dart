import 'package:picnic_app/core/domain/model/connection_status_changed_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_deleted_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_received_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_updated_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/messages_reaction_update_chat_event.dart';

abstract class ChatEvent {
  ChatEventType get type;
}

extension ChatEventSwitch on ChatEvent {
  /// convenience method that allows for exhaustive switching on different types of events
  /// with smart casting the type of event
  // ignore: long-parameter-list
  void when({
    Function(MessageReceivedChatEvent event)? newMessagesReceived,
    Function(MessagesReactionUpdateChatEvent event)? messageReactionUpdated,
    Function(ConnectionStatusChangedEvent event)? connectionStatusChanged,
    Function(MessageUpdatedChatEvent event)? messageUpdated,
    Function(MessageDeletedChatEvent event)? messageDeleted,
  }) {
    switch (type) {
      case ChatEventType.newMessageReceived:
        newMessagesReceived?.call(this as MessageReceivedChatEvent);
        return;
      case ChatEventType.messageReactionUpdated:
        messageReactionUpdated?.call(this as MessagesReactionUpdateChatEvent);
        return;
      case ChatEventType.connectionStatusChanged:
        connectionStatusChanged?.call(this as ConnectionStatusChangedEvent);
        return;
      case ChatEventType.messageUpdated:
        messageUpdated?.call(this as MessageUpdatedChatEvent);
        return;
      case ChatEventType.messageDeleted:
        messageDeleted?.call(this as MessageDeletedChatEvent);
        return;
      case ChatEventType.unknown:
      //Chat updated is handled other in UnreadChatsPresenter
      case ChatEventType.chatUpdated:
        return;
    }
  }
}
