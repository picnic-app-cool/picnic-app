import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_special_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatGlitterBomb extends Equatable implements ChatSpecialMessage {
  const ChatGlitterBomb({
    required this.username,
    required this.userId,
  });

  const ChatGlitterBomb.empty()
      : userId = const Id.empty(),
        username = "";

  final Id userId;
  final String username;

  @override
  ChatComponentType get type => ChatComponentType.glitterBomb;

  @override
  List<Object?> get props => [
        userId,
        username,
      ];

  ChatGlitterBomb copyWith({
    Id? userId,
    String? username,
  }) {
    return ChatGlitterBomb(
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }
}
