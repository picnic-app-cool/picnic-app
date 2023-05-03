import 'package:picnic_app/core/data/graphql/model/gql_attachment.dart';
import 'package:picnic_app/core/data/graphql/model/gql_chat_member_json.dart';
import 'package:picnic_app/core/data/graphql/model/gql_embed.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_component_json.dart';
import 'package:picnic_app/features/chat/data/model/gql_chat_message_reaction_json.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_status.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlChatMessageJson {
  const GqlChatMessageJson({
    required this.id,
    required this.content,
    required this.chatMessageType,
    required this.createdAt,
    required this.authorJson,
    required this.replyContent,
    required this.reactions,
    required this.mentions,
    required this.component,
    required this.attachmentIds,
    required this.attachments,
    required this.embeds,
    required this.member,
  });

  // ignore: long-method
  factory GqlChatMessageJson.fromJson(Map<String, dynamic>? json) {
    var reactions = <GqlChatMessageReactionJson>[];
    GqlChatMessageJson? replyContent;
    GqlChatComponentJson? component;
    GqlChatMemberJson? member;

    if (json != null && json.containsKey('reactions')) {
      reactions = asList(
        json,
        'reactions',
        GqlChatMessageReactionJson.fromJson,
      );
    }

    final attachmentIds = json != null
        ? asListPrimitive<String>(
            json,
            'attachmentIds',
          )
        : const <String>[];

    var attachments = <GqlAttachment>[];

    if (json != null && json.containsKey('attachments')) {
      attachments = asList(
        json,
        'attachments',
        GqlAttachment.fromJson,
      );
    }

    final embeds = <GqlEmbed>[];

    if (json != null && json.containsKey('embeds')) {
      embeds.addAll(
        asList(
          json,
          'embeds',
          GqlEmbed.fromJson,
        ),
      );
    }

    if (json != null && json['replyContent'] != null) {
      replyContent = GqlChatMessageJson.fromJson(asT<Map<String, dynamic>>(json, 'replyContent'));
    }

    if (json != null && json.containsKey('component') && json['component'] != null) {
      final componentJson = json['component'] as Map<String, dynamic>;
      final componentType = ChatComponentType.fromString(componentJson['type'] as String);
      if (ChatComponentType.values.contains(componentType)) {
        component = GqlChatComponentJson.fromJson(componentJson);
      }
    }

    if (json != null && json.containsKey('member') && json['member'] != null) {
      final memberJson = json['member'] as Map<String, dynamic>;
      member = GqlChatMemberJson.fromJson(memberJson);
    }

    return GqlChatMessageJson(
      id: asT<String>(json, 'id'),
      content: asT<String>(json, 'content'),
      chatMessageType: asT<String>(json, 'type'),
      createdAt: asT<String>(json, 'createdAt'),
      authorJson: asT<Map<String, dynamic>>(json, 'author'),
      replyContent: replyContent,
      reactions: reactions,
      mentions: asT<List<dynamic>>(json, 'mentions'),
      component: component,
      attachmentIds: attachmentIds,
      attachments: attachments,
      embeds: embeds,
      member: member,
    );
  }

  final String id;
  final String content;
  final String chatMessageType;
  final String createdAt;
  final Map<String, dynamic> authorJson;
  final GqlChatMessageJson? replyContent;
  final List<GqlChatMessageReactionJson> reactions;
  final List<dynamic> mentions;
  final GqlChatComponentJson? component;
  final List<String> attachmentIds;
  final List<GqlAttachment> attachments;
  final List<GqlEmbed> embeds;
  final GqlChatMemberJson? member;

  ChatMessage toDomain() => ChatMessage(
        id: Id(id),
        content: content,
        chatMessageType: ChatMessageType.fromString(chatMessageType),
        author: GqlUser.fromJson(authorJson).toDomain(),
        chatMessageStatus: ChatMessageStatus.viewed,
        createdAtString: createdAt,
        chatMessageSender: ChatMessageSender.user,
        reactions: reactions.map((e) => e.toDomain()).toList(),
        repliedContent: replyContent?.toDomain(),
        component: component?.toDomain(),
        attachmentIds: attachmentIds.map((value) => Id(value)).toList(),
        attachments: attachments.map((attachment) => attachment.toDomain()).toList(),
        embeds: embeds.map((embed) => embed.toDomain()).toList(),
        member: member?.toDomain() ?? const ChatMember.empty(),
      );
}
