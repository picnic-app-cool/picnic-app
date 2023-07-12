import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/chat_circle_invite.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_glitter_bomb.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_post_payload.dart';

abstract class ChatSpecialMessage {
  ChatComponentType get type;
}

extension ChatSpecialMessageSwitch on ChatSpecialMessage {
  T when<T>({
    required T Function(ChatCircleInvite content) circleInvite,
    required T Function(ChatGlitterBomb content) glitterBomb,
    required T Function(ChatMessagePostPayload content) post,
    required T Function() unknownContent,
  }) {
    switch (type) {
      case ChatComponentType.circleInvite:
        return circleInvite(cast(this));
      case ChatComponentType.glitterBomb:
        return glitterBomb(cast(this));
      case ChatComponentType.post:
        return post(cast(this));
      case ChatComponentType.unknown:
        return unknownContent();
    }
  }
}
