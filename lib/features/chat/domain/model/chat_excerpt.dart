import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatExcerpt extends Equatable {
  const ChatExcerpt({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.chatType,
    required this.language,
    required this.participantsCount,
    required this.circle,
    required this.messages,
  });

  ChatExcerpt.empty()
      : id = const Id.none(),
        name = '',
        imageUrl = '',
        chatType = ChatType.single,
        language = '',
        participantsCount = 0,
        circle = const Circle.empty(),
        messages = List.empty();

  final Id id;
  final String name;
  final String imageUrl;
  final ChatType chatType;
  final String language;
  final int participantsCount;
  final Circle circle;
  final List<ChatMessage> messages;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        chatType,
        language,
        participantsCount,
        circle,
        messages,
      ];

  ChatExcerpt copyWith({
    Id? id,
    String? name,
    String? imageUrl,
    ChatType? chatType,
    String? language,
    int? participantsCount,
    Circle? circle,
    List<ChatMessage>? messages,
  }) {
    return ChatExcerpt(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      chatType: chatType ?? this.chatType,
      language: language ?? this.language,
      participantsCount: participantsCount ?? this.participantsCount,
      circle: circle ?? this.circle,
      messages: messages ?? this.messages,
    );
  }
}
