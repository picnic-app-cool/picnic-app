import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';

class GqlChatMetaDataJson {
  const GqlChatMetaDataJson({
    required this.chatId,
    required this.chatType,
    required this.lastMessageAt,
  });

  factory GqlChatMetaDataJson.fromJson(Map<String, dynamic>? json) => GqlChatMetaDataJson(
        chatId: asT<String>(json, 'chatId'),
        chatType: asT<String>(json, 'chatType'),
        lastMessageAt: asT<String>(json, 'lastMessageAt'),
      );

  final String chatId;
  final String chatType;
  final String lastMessageAt;

  UnreadChat toDomain() => UnreadChat(
        chatId: Id(chatId),
        chatType: ChatType.fromString(chatType),
        lastMessageAtString: lastMessageAt,
        unreadMessagesCount: 0,
      );
}
