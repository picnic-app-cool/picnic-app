import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method, too_many_public_members, nullable_field_in_domain_entity
abstract class ChatMessagesAction {
  factory ChatMessagesAction.init({
    required List<Id> chatIds,
  }) =>
      ChatMessagesActionInit(chatIds: chatIds);

  factory ChatMessagesAction.loadMore() => ChatMessagesActionLoadMore();

  factory ChatMessagesAction.deleteMessage(ChatMessage message) => ChatMessagesActionDeleteMessage(message: message);

  factory ChatMessagesAction.sendMessage({
    required ChatMessage message,
    required ChatMessage? replyToMessage,
  }) =>
      ChatMessagesActionSendMessage(
        message: message,
        replyToMessage: replyToMessage,
      );

  factory ChatMessagesAction.resendMessage({
    required ChatMessage message,
  }) =>
      ChatMessagesActionResendMessage(
        message: message,
        replyToMessage: null,
      );

  factory ChatMessagesAction.reaction(ChatMessage message, ChatMessageReactionType reactionType) =>
      ChatMessagesActionReaction(message: message, reactionType: reactionType);

  factory ChatMessagesAction.copy(ChatMessage message) => ChatMessagesActionCopy(message: message);

  factory ChatMessagesAction.joinCircle(BasicCircle circle) => ChatMessagesActionJoinCircle(circle: circle);

  factory ChatMessagesAction.unblur(Id attachmentId) => ChatMessagesActionUnblur(attachmentId: attachmentId);

  factory ChatMessagesAction.disconnect() => ChatMessagesActionDisconnect();

  ChatMessagesActionType get type;
}

class ChatMessagesActionInit implements ChatMessagesAction {
  ChatMessagesActionInit({required this.chatIds});

  final List<Id> chatIds;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.init;
}

class ChatMessagesActionLoadMore extends Equatable implements ChatMessagesAction {
  @override
  ChatMessagesActionType get type => ChatMessagesActionType.loadMore;

  @override
  List<Object?> get props => [type];
}

class ChatMessagesActionDeleteMessage implements ChatMessagesAction {
  const ChatMessagesActionDeleteMessage({
    required this.message,
  });

  final ChatMessage message;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.deleteMessage;
}

class ChatMessagesActionSendMessage implements ChatMessagesAction {
  const ChatMessagesActionSendMessage({
    required this.message,
    required this.replyToMessage,
  });

  final ChatMessage message;
  final ChatMessage? replyToMessage;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.sendMessage;

  ChatMessageInput getMessageInput({List<Attachment> withAttachments = const []}) {
    var messageInput = ChatMessageInput.fromChatMessage(
      message: message.copyWith(
        attachmentIds: withAttachments
            .map(
              (attachment) => attachment.id,
            )
            .toList(),
      ),
    );
    if (replyToMessage != null) {
      messageInput = messageInput.copyWith(repliedToMessageId: replyToMessage!.id);
    }
    return messageInput;
  }
}

class ChatMessagesActionResendMessage extends ChatMessagesActionSendMessage {
  ChatMessagesActionResendMessage({required super.message, required super.replyToMessage});

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.resendMessage;
}

class ChatMessagesActionReaction implements ChatMessagesAction {
  const ChatMessagesActionReaction({
    required this.message,
    required this.reactionType,
  });

  final ChatMessage message;
  final ChatMessageReactionType reactionType;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.reaction;

  @override
  int get hashCode => message.hashCode + reactionType.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ChatMessagesActionReaction &&
      other.runtimeType == runtimeType &&
      other.message == message &&
      other.reactionType == reactionType;
}

class ChatMessagesActionCopy implements ChatMessagesAction {
  const ChatMessagesActionCopy({
    required this.message,
  });

  final ChatMessage message;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.copy;
}

class ChatMessagesActionJoinCircle implements ChatMessagesAction {
  const ChatMessagesActionJoinCircle({
    required this.circle,
  });

  final BasicCircle circle;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.joinCircle;
}

class ChatMessagesActionUnblur implements ChatMessagesAction {
  const ChatMessagesActionUnblur({
    required this.attachmentId,
  });

  final Id attachmentId;

  @override
  ChatMessagesActionType get type => ChatMessagesActionType.unblur;
}

class ChatMessagesActionDisconnect implements ChatMessagesAction {
  @override
  ChatMessagesActionType get type => ChatMessagesActionType.disconnect;
}

extension ChatMessagesActionWhen on ChatMessagesAction {
  //ignore: long-parameter-list
  T when<T>({
    required T Function(ChatMessagesActionInit action) init,
    required T Function(ChatMessagesActionLoadMore action) loadMore,
    required T Function(ChatMessagesActionDeleteMessage action) deleteMessage,
    required T Function(ChatMessagesActionSendMessage action) sendMessage,
    required T Function(ChatMessagesActionCopy action) copy,
    required T Function(ChatMessagesActionJoinCircle action) joinCircle,
    required T Function(ChatMessagesActionUnblur action) unblur,
    required T Function(ChatMessagesActionResendMessage action) resend,
    required T Function(ChatMessagesActionReaction action) reaction,
    required T Function(ChatMessagesActionDisconnect action) disconnect,
  }) {
    switch (type) {
      case ChatMessagesActionType.init:
        return init(this as ChatMessagesActionInit);
      case ChatMessagesActionType.loadMore:
        return loadMore(this as ChatMessagesActionLoadMore);
      case ChatMessagesActionType.deleteMessage:
        return deleteMessage(this as ChatMessagesActionDeleteMessage);
      case ChatMessagesActionType.sendMessage:
        return sendMessage(this as ChatMessagesActionSendMessage);
      case ChatMessagesActionType.copy:
        return copy(this as ChatMessagesActionCopy);
      case ChatMessagesActionType.joinCircle:
        return joinCircle(this as ChatMessagesActionJoinCircle);
      case ChatMessagesActionType.unblur:
        return unblur(this as ChatMessagesActionUnblur);
      case ChatMessagesActionType.resendMessage:
        return resend(this as ChatMessagesActionResendMessage);
      case ChatMessagesActionType.reaction:
        return reaction(this as ChatMessagesActionReaction);
      case ChatMessagesActionType.disconnect:
        return disconnect(this as ChatMessagesActionDisconnect);
    }
  }
}

enum ChatMessagesActionType {
  init,
  loadMore,
  deleteMessage,
  sendMessage,
  copy,
  joinCircle,
  unblur,
  resendMessage,
  reaction,
  disconnect,
}
