import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_circle_invite_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_glitter_bomb_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';

class GqlChatComponentJson {
  const GqlChatComponentJson({
    required this.type,
    required this.payload,
  });

  factory GqlChatComponentJson.fromJson(Map<String, dynamic>? json) => GqlChatComponentJson(
        type: asT<String>(json, 'type'),
        payload: asT<Map<String, dynamic>>(json, 'payload'),
      );

  final String type;
  final Map<String, dynamic> payload;

  ChatSpecialMessage get specialMessagePayload {
    final payloadType = ChatComponentType.fromString(type);
    switch (payloadType) {
      case ChatComponentType.circleInvite:
        return GqlChatCircleInviteJson.fromJson(payload).toDomain();
      case ChatComponentType.glitterBomb:
        return GqlChatGlitterBombJson.fromJson(payload).toDomain();
      case ChatComponentType.unknown:
        return GqlChatCircleInviteJson.fromJson(payload).toDomain();
    }
  }

  ChatComponent toDomain() => ChatComponent(
        type: ChatComponentType.fromString(type),
        payload: specialMessagePayload,
      );
}
