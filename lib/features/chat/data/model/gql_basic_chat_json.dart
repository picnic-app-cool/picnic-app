import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_json.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlBasicChatJson {
  const GqlBasicChatJson({
    required this.id,
    required this.name,
    required this.chatType,
    required this.participantsCount,
    required this.unreadMessagesCount,
    required this.participantsConnection,
    required this.messagesConnection,
    required this.image,
  });

  factory GqlBasicChatJson.fromJson(Map<String, dynamic>? json) {
    GqlConnection? messagesConnection;
    if (json != null && json['messagesConnection'] != null) {
      messagesConnection = GqlConnection.fromJson(asT<Map<String, dynamic>>(json, 'messagesConnection'));
    }

    GqlConnection? participantsConnection;
    if (json != null && json['participantsConnection'] != null) {
      participantsConnection = GqlConnection.fromJson(asT<Map<String, dynamic>>(json, 'participantsConnection'));
    }

    return GqlBasicChatJson(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
      chatType: asT<String>(json, 'chatType'),
      participantsCount: asT<int>(json, 'participantsCount'),
      image: asT<String>(json, 'chatImage'),
      messagesConnection: messagesConnection,
      participantsConnection: participantsConnection,
      unreadMessagesCount: asT<int>(json, 'unreadMessagesCount'),
    );
  }

  final String id;
  final String name;
  final String chatType;
  final String? image;
  final int participantsCount;
  final int unreadMessagesCount;
  final GqlConnection? messagesConnection;
  final GqlConnection? participantsConnection;

  BasicChat toDomain() => BasicChat(
        id: Id(id),
        name: name,
        chatType: ChatType.fromString(chatType),
        participantsCount: participantsCount,
        unreadMessagesCount: unreadMessagesCount,
        image: ImageUrl(image ?? ""),
        latestMessages: messagesConnection?.toDomain(
              nodeMapper: (node) => GqlChatMessageJson.fromJson(node).toDomain(),
            ) ??
            const PaginatedList.empty(),
        createdAtString: "",
        participants: participantsConnection?.toDomain(nodeMapper: (node) => GqlUser.fromJson(node).toDomain()) ??
            const PaginatedList.empty(),
      );
}
