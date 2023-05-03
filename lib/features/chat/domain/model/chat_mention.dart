import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';

//ignore_for_file: unused-code, unused-files
class ChatMention extends Equatable {
  const ChatMention({
    required this.user,
    required this.id,
  });

  const ChatMention.empty()
      : user = const User.empty(),
        id = '';

  final String id;
  final User user;

  @override
  List<Object?> get props => [user, id];

  ChatMention copyWith({
    User? user,
    String? id,
  }) {
    return ChatMention(
      user: user ?? this.user,
      id: id ?? this.id,
    );
  }
}
