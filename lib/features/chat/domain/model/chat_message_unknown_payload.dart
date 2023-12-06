import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';

class ChatMessageUnknownPayload extends Equatable implements ChatSpecialMessage {
  const ChatMessageUnknownPayload();

  const ChatMessageUnknownPayload.empty();

  @override
  ChatComponentType get type => ChatComponentType.unknown;

  @override
  List<Object?> get props => [];

  ChatMessageUnknownPayload copyWith() {
    return const ChatMessageUnknownPayload();
  }
}
