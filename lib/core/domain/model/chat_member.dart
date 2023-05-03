import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/chat_role.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ChatMember extends Equatable {
  const ChatMember({
    required this.userId,
    required this.role,
    required this.user,
  });

  const ChatMember.empty()
      : userId = const Id.empty(),
        role = ChatRole.none,
        user = const User.empty();

  final Id userId;
  final ChatRole role;
  final User user;

  @override
  List<Object?> get props => [
        userId,
        role,
        user,
      ];

  ChatMember copyWith({
    Id? userId,
    ChatRole? role,
    User? user,
  }) {
    return ChatMember(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      user: user ?? this.user,
    );
  }
}
