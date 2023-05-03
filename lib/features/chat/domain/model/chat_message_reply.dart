import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';

//ignore_for_file: unused-code, unused-files
class ChatMessageReply extends Equatable {
  const ChatMessageReply({
    required this.user,
    required this.id,
  });

  const ChatMessageReply.empty()
      : user = const User.empty(),
        id = '';

  final String id;
  final User user;

  @override
  List<Object?> get props => [user, id];

  ChatMessageReply copyWith({
    User? user,
    String? id,
  }) {
    return ChatMessageReply(
      user: user ?? this.user,
      id: id ?? this.id,
    );
  }
}
