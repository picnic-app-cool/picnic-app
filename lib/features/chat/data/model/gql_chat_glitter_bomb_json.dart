import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/chat_glitter_bomb.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlChatGlitterBombJson {
  const GqlChatGlitterBombJson({
    required this.userId,
    required this.username,
  });

  factory GqlChatGlitterBombJson.fromJson(Map<String, dynamic>? json) {
    final author = asT<Map<String, dynamic>>(json, 'sender');
    return GqlChatGlitterBombJson(
      userId: asT<String>(author, 'id'),
      username: asT<String>(author, 'username'),
    );
  }

  final String userId;
  final String username;

  ChatGlitterBomb toDomain() => ChatGlitterBomb(userId: Id(userId), username: username);
}
