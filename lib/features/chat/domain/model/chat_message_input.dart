import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_component_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatMessageInput extends Equatable {
  const ChatMessageInput({
    required this.content,
    required this.type,
    required this.repliedToMessageId,
    required this.attachmentIds,
    required this.component,
  });

  const ChatMessageInput.empty()
      : content = '',
        type = ChatMessageType.text,
        repliedToMessageId = const Id.none(),
        attachmentIds = const [],
        component = const ChatMessageComponentInput.empty();

  ChatMessageInput.fromChatMessage({required ChatMessage message})
      : content = message.content,
        type = message.chatMessageType,
        repliedToMessageId = message.hasRepliedContent ? message.repliedContent!.id : const Id.none(),
        attachmentIds = message.attachmentIds,
        component = const ChatMessageComponentInput.empty();

  final String content;
  final ChatMessageType type;
  final Id repliedToMessageId;
  final List<Id> attachmentIds;
  final ChatMessageComponentInput component;

  @override
  List<Object> get props => [
        content,
        type,
        repliedToMessageId,
        attachmentIds,
        component,
      ];

  ChatMessageInput copyWith({
    String? content,
    ChatMessageType? type,
    Id? repliedToMessageId,
    List<Id>? attachmentIds,
    ChatMessageComponentInput? component,
  }) {
    return ChatMessageInput(
      content: content ?? this.content,
      type: type ?? this.type,
      repliedToMessageId: repliedToMessageId ?? this.repliedToMessageId,
      attachmentIds: attachmentIds ?? this.attachmentIds,
      component: component ?? this.component,
    );
  }
}
