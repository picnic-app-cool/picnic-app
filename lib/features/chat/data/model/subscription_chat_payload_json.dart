import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat_event_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_updated_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_deleted_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_received_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_updated_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/messages_reaction_update_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/unknown_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';

abstract class SubscriptionChatPayloadJson {
  factory SubscriptionChatPayloadJson.fromJson({
    required Map<String, dynamic> json,
  }) {
    final event = asT<String>(json, 'event');
    final chatEventType = ChatEventType.fromString(event);
    final payloadJson = json["payload"] as Map<String, dynamic>;

    switch (chatEventType) {
      case ChatEventType.newMessageReceived:
        return SubscriptionChatNewMessagePayloadJson.fromJson(payloadJson);
      case ChatEventType.messageReactionUpdated:
        return SubscriptionMessageReactionPayloadJson.fromJson(payloadJson);
      case ChatEventType.messageUpdated:
        return SubscriptionChatUpdatedMessagePayloadJson.fromJson(payloadJson);
      case ChatEventType.messageDeleted:
        return SubscriptionMessageDeletedPayloadJson.fromJson(payloadJson);
      case ChatEventType.chatUpdated:
        return SubscriptionChatUpdatedPayloadJson.fromJson(payloadJson);
      default:
        return SubscriptionChatUnknownPayloadJson.fromJson(json);
    }
  }

  ChatEvent toChatEvent();
}

class SubscriptionChatNewMessagePayloadJson implements SubscriptionChatPayloadJson {
  const SubscriptionChatNewMessagePayloadJson({
    required GqlChatMessageJson message,
  }) : _message = message;

  factory SubscriptionChatNewMessagePayloadJson.fromJson(Map<String, dynamic> json) =>
      SubscriptionChatNewMessagePayloadJson(message: GqlChatMessageJson.fromJson(json));

  final GqlChatMessageJson _message;

  @override
  ChatEvent toChatEvent() => MessageReceivedChatEvent(
        message: _message.toDomain(),
      );
}

class SubscriptionMessageReactionPayloadJson implements SubscriptionChatPayloadJson {
  const SubscriptionMessageReactionPayloadJson({
    required Map<String, dynamic> json,
  }) : _json = json;

  factory SubscriptionMessageReactionPayloadJson.fromJson(Map<String, dynamic> json) =>
      SubscriptionMessageReactionPayloadJson(json: json);

  final Map<String, dynamic> _json;

  @override
  ChatEvent toChatEvent() => MessagesReactionUpdateChatEvent(
        messageId: Id(asT<String>(_json, 'messageId')),
        reactionType: ChatMessageReactionType(asT<String>(_json, 'reaction')),
        count: asT<int>(_json, 'count'),
      );
}

// ignore: prefer-correct-type-name
class SubscriptionChatUpdatedMessagePayloadJson implements SubscriptionChatPayloadJson {
  const SubscriptionChatUpdatedMessagePayloadJson({
    required GqlChatMessageJson message,
  }) : _message = message;

  factory SubscriptionChatUpdatedMessagePayloadJson.fromJson(Map<String, dynamic> json) =>
      SubscriptionChatUpdatedMessagePayloadJson(message: GqlChatMessageJson.fromJson(json));

  final GqlChatMessageJson _message;

  @override
  ChatEvent toChatEvent() => MessageUpdatedChatEvent(
        message: _message.toDomain(),
      );
}

class SubscriptionMessageDeletedPayloadJson implements SubscriptionChatPayloadJson {
  const SubscriptionMessageDeletedPayloadJson({
    required Map<String, dynamic> json,
  }) : _json = json;

  factory SubscriptionMessageDeletedPayloadJson.fromJson(Map<String, dynamic> json) =>
      SubscriptionMessageDeletedPayloadJson(json: json);

  final Map<String, dynamic> _json;

  @override
  ChatEvent toChatEvent() => MessageDeletedChatEvent(
        chatId: Id(asT<String>(_json, 'chatId')),
        messageId: Id(asT<String>(_json, 'messageId')),
      );
}

class SubscriptionChatUnknownPayloadJson implements SubscriptionChatPayloadJson {
  const SubscriptionChatUnknownPayloadJson({
    required this.json,
  });

  factory SubscriptionChatUnknownPayloadJson.fromJson(Map<String, dynamic> json) =>
      SubscriptionChatUnknownPayloadJson(json: json);

  final Map<String, dynamic> json;

  @override
  ChatEvent toChatEvent() => UnknownChatEvent(payload: json.toString());
}

class SubscriptionChatUpdatedPayloadJson implements SubscriptionChatPayloadJson {
  const SubscriptionChatUpdatedPayloadJson({
    required this.json,
  });

  factory SubscriptionChatUpdatedPayloadJson.fromJson(Map<String, dynamic> json) =>
      SubscriptionChatUpdatedPayloadJson(json: json);

  final Map<String, dynamic> json;

  @override
  ChatEvent toChatEvent() => ChatUpdatedEvent(
        chatId: Id(asT<String>(json, 'chatId')),
        unreadMessagesCount: asT<int>(json, 'unreadMessagesCount'),
        chatType: ChatType.fromString(asT<String>(json, 'chatType')),
      );
}
