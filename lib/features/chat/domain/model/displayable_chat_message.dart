import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_group.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';

///  model that helps with storing auxiliary message data required for proper display
class DisplayableChatMessage extends Equatable {
  const DisplayableChatMessage({
    required this.isFirstInGroup,
    required this.isLastInGroup,
    this.showAuthor = false,
    required this.chatMessage,
    required this.previousMessage,
  });

  const DisplayableChatMessage.empty()
      : isFirstInGroup = false,
        isLastInGroup = false,
        showAuthor = false,
        chatMessage = const ChatMessage.empty(),
        previousMessage = const ChatMessage.empty();

  final bool isFirstInGroup;
  final bool isLastInGroup;
  final bool showAuthor;
  final ChatMessage chatMessage;
  final ChatMessage previousMessage;

  @override
  List<Object> get props => [
        isFirstInGroup,
        isLastInGroup,
        showAuthor,
        chatMessage,
        previousMessage,
      ];

  DisplayableChatMessage byUpdatingChatMessage(
    ChatMessage Function(ChatMessage message) updater,
  ) =>
      copyWith(chatMessage: updater(chatMessage));

  DisplayableChatMessage byUpdatingReaction(ChatMessageReaction reaction) =>
      byUpdatingChatMessage((message) => message.byUpdatingReaction(reaction));

  DisplayableChatMessage copyWith({
    bool? isFirstInGroup,
    bool? isLastInGroup,
    bool? showAuthor,
    ChatMessage? chatMessage,
    ChatMessage? previousMessage,
  }) {
    return DisplayableChatMessage(
      isFirstInGroup: isFirstInGroup ?? this.isFirstInGroup,
      isLastInGroup: isLastInGroup ?? this.isLastInGroup,
      showAuthor: showAuthor ?? this.showAuthor,
      chatMessage: chatMessage ?? this.chatMessage,
      previousMessage: previousMessage ?? this.previousMessage,
    );
  }
}

extension DisplayableChatMessageListWrapper on List<ChatMessage> {
  List<DisplayableChatMessage> byWrappingMessages() =>
      bySplittingMessages().expand((group) => group.byExpandingChatGroup()).toList();
}

extension DisplayableChatMessageListExpander on ChatMessageGroup {
  List<DisplayableChatMessage> byExpandingChatGroup() => messages.mapIndexed(
        (index, message) {
          final isLastElement = message == messages.last;
          final nextIndex = index + 1;
          final previousMessage =
              messages.isNotEmpty && !isLastElement ? messages.elementAt(nextIndex) : const ChatMessage.empty();

          return DisplayableChatMessage(
            isFirstInGroup: index == 0,
            chatMessage: message,
            isLastInGroup: message == messages.last,
            previousMessage: previousMessage,
          );
        },
      ).toList();
}

extension ChatMessageGroupSplitter on List<ChatMessage> {
  List<ChatMessageGroup> bySplittingMessages() => splitBetween((first, second) => first.author.id != second.author.id)
      .map(
        (messages) => ChatMessageGroup(
          author: messages.first.author,
          messages: messages,
        ),
      )
      .toList();
}
