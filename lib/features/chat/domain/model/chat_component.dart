import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_circle_invite.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';

class ChatComponent extends Equatable {
  const ChatComponent({
    required this.type,
    required this.payload,
  });

  const ChatComponent.empty()
      : type = ChatComponentType.unknown,
        payload = const ChatCircleInvite.empty();

  final ChatComponentType type;
  final ChatSpecialMessage payload;

  @override
  List<Object?> get props => [
        type,
        payload,
      ];

  ChatComponent copyWith({
    ChatComponentType? type,
    ChatSpecialMessage? payload,
  }) {
    return ChatComponent(
      type: type ?? this.type,
      payload: payload ?? this.payload,
    );
  }
}
