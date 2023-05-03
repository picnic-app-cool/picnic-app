import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';

class ChatMessagesFeed extends Equatable {
  const ChatMessagesFeed({
    required this.name,
    required this.membersCount,
    required this.messages,
    required this.circle,
  });

  const ChatMessagesFeed.empty()
      : name = '',
        membersCount = 0,
        messages = const [],
        circle = const Circle.empty();

  final String name;
  final int membersCount;
  final List<ChatMessage> messages;
  final Circle circle;

  String get emoji => circle.emoji;

  String get image => circle.imageFile;

  @override
  List<Object?> get props => [
        name,
        membersCount,
        messages,
        circle,
      ];

  ChatMessagesFeed copyWith({
    String? name,
    int? membersCount,
    List<ChatMessage>? messages,
    Circle? circle,
  }) {
    return ChatMessagesFeed(
      name: name ?? this.name,
      membersCount: membersCount ?? this.membersCount,
      messages: messages ?? this.messages,
      circle: circle ?? this.circle,
    );
  }
}
