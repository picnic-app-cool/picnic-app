import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';

/// Group of chat messages that belong to a single user posted one after another
class ChatMessageGroup extends Equatable {
  const ChatMessageGroup({
    required this.author,
    required this.messages,
  });

  const ChatMessageGroup.empty()
      : author = const User.empty(),
        messages = const [];

  final User author;
  final List<ChatMessage> messages;

  @override
  List<Object> get props => [
        author,
        messages,
      ];

  /// splits messages list into separate chat message groups
  /// so that consecutive messages from one author are within one group
  static List<ChatMessageGroup> bySplittingMessages(
    List<ChatMessage> messages,
  ) =>
      messages
          .splitBetween((first, second) => first.author.id != second.author.id)
          .map(
            (messages) => ChatMessageGroup(
              author: messages.first.author,
              messages: messages,
            ),
          )
          .toList();

  ChatMessageGroup copyWith({
    User? author,
    List<ChatMessage>? messages,
  }) {
    return ChatMessageGroup(
      author: author ?? this.author,
      messages: messages ?? this.messages,
    );
  }
}
