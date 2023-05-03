import 'package:picnic_app/core/data/graphql/model/gql_circle.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat_excerpt.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlChatExcerptJson {
  const GqlChatExcerptJson({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.chatType,
    required this.language,
    required this.participantsCount,
    required this.messages,
    required this.circleJson,
  });

  factory GqlChatExcerptJson.fromJson(Map<String, dynamic>? json) {
    List<GqlChatMessageJson>? messages;

    if (json != null && json['messages'] != null) {
      messages = asList(
        json,
        'messages',
        GqlChatMessageJson.fromJson,
      );
    }
    return GqlChatExcerptJson(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
      imageUrl: asT<String>(json, 'imageUrl'),
      chatType: asT<String>(json, 'chatType'),
      language: asT<String>(json, 'language'),
      participantsCount: asT<int>(json, 'participantsCount'),
      messages: messages ?? List.empty(),
      circleJson: asT<Map<String, dynamic>>(json, 'circle'),
    );
  }

  final String id;
  final String name;
  final String imageUrl;
  final String chatType;
  final String language;
  final int participantsCount;
  final List<GqlChatMessageJson> messages;
  final Map<String, dynamic> circleJson;

  ChatExcerpt toDomain() => ChatExcerpt(
        id: Id(id),
        name: normalizeString(name),
        imageUrl: imageUrl,
        chatType: ChatType.fromString(chatType),
        language: language,
        participantsCount: participantsCount,
        circle: GqlCircle.fromJson(circleJson).toDomain(),
        messages: messages.map((e) => e.toDomain()).toList(),
      );
}
