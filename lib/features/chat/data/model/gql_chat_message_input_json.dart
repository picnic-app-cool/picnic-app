import 'package:picnic_app/features/chat/domain/model/chat_message_component_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';

extension GqlChatMessageInputJson on ChatMessageInput {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'type': type.stringVal,
      'repliedToMessageId': repliedToMessageId.isNone ? null : repliedToMessageId.value,
      if (attachmentIds.isNotEmpty) 'attachmentIds': attachmentIds.map((id) => id.value).toList(),
      if (component != const ChatMessageComponentInput.empty()) 'component': component.toJson(),
    };
  }
}

extension GqlChatMessageComponentInputJson on ChatMessageComponentInput {
  Map<String, dynamic> toJson() {
    return {
      'type': type.stringVal,
      if (circleInvite != const ChatMessageCircleInviteInput.empty()) 'circleInvite': circleInvite.toJson(),
      if (seedsExchange != const ChatMessageSeedsExchangeInput.empty()) 'seedsExchange': seedsExchange.toJson(),
      if (glitterBomb != const ChatMessageGlitterBombInput.empty()) 'glitterBomb': glitterBomb.toJson(),
      if (entity != const ChatMessageEntityInput.empty()) 'entity': entity.toJson(),
    };
  }
}

extension GqlChatMessageCircleInviteInputJson on ChatMessageCircleInviteInput {
  Map<String, dynamic> toJson() {
    return {
      'circleId': circleId.value,
      'userId': userId.value,
    };
  }
}

extension GqlChatMessageSeedsExchangeInputJson on ChatMessageSeedsExchangeInput {
  Map<String, dynamic> toJson() {
    return {
      'offerId': offerId.value,
      'userId': userId.value,
    };
  }
}

extension GqlChatMessageGlitterBombInputJson on ChatMessageGlitterBombInput {
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId.value,
    };
  }
}

extension GqlChatMessageEntityInputJson on ChatMessageEntityInput {
  Map<String, dynamic> toJson() {
    return {
      'entityId': entityId.value,
    };
  }
}
