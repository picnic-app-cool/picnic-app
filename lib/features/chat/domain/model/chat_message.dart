import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_mention.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_status.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_role.dart';
import 'package:picnic_app/features/chat/domain/model/embed.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/utils/extensions/date_formatting.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

//ignore_for_file:nullable_field_in_domain_entity
class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.chatMessageType,
    required this.chatMessageStatus,
    required this.chatMessageSender,
    required this.author,
    this.repliedContent,
    this.chatMention = const [ChatMention.empty()],
    required this.reactions,
    required this.createdAtString,
    this.component,
    this.attachmentIds = const [],
    this.attachments = const [],
    this.embeds = const [],
    required this.member,
  });

  const ChatMessage.empty()
      : content = '',
        id = const Id.none(),
        chatMessageStatus = ChatMessageStatus.created,
        chatMessageType = ChatMessageType.text,
        chatMessageSender = ChatMessageSender.user,
        repliedContent = null,
        createdAtString = "",
        reactions = const [],
        author = const User.empty(),
        chatMention = const [ChatMention.empty()],
        component = null,
        attachmentIds = const [],
        attachments = const [],
        embeds = const [],
        member = const ChatMember.empty();

  final Id id;
  final String content;

  final ChatMessage? repliedContent;

  //for V1 we will only have one reaction being like
  final List<ChatMessageReaction> reactions;
  final ChatMessageStatus chatMessageStatus;
  final ChatMessageType chatMessageType;
  final ChatMessageSender chatMessageSender;
  final User author;
  final List<ChatMention> chatMention;
  final String createdAtString;
  final ChatComponent? component;
  final List<Id> attachmentIds;
  final List<Attachment> attachments;
  final List<Embed> embeds;
  final ChatMember member;

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  @override
  List<Object?> get props => [
        id,
        content,
        chatMessageType,
        chatMessageStatus,
        chatMessageSender,
        reactions,
        repliedContent,
        author,
        chatMention,
        createdAtString,
        component,
        attachmentIds,
        attachments,
        embeds,
        member,
      ];

  String get displayableContent {
    if (content.isEmpty) {
      if (attachments.isNotEmpty) {
        return appLocalizations.chatMessageEmptyContentWithAttachment(authorFormattedUsername);
      }
      if (isCircleInvitation) {
        return appLocalizations.chatInvitationMessage(authorFormattedUsername);
      }
      if (isGlitterBomb) {
        return appLocalizations.chatGlitterBombMessage(author.username);
      }
    }
    return content;
  }

  bool get isEmptyMessage {
    return content.trim().isEmpty && attachments.isEmpty && !isComponentType;
  }

  int get reactionsCount => reactions.map((e) => e.count).fold(0, (a, b) => a + b);

  String get authorFormattedUsername => author.username.formattedUsername;

  Id get authorId => author.id;

  bool get isRead => chatMessageStatus == ChatMessageStatus.viewed;

  bool get isPending => id == const Id.none();

  bool get isNotSent => chatMessageStatus == ChatMessageStatus.notSent;

  bool get hasRepliedContent => repliedContent != null;

  bool get isComponentType => chatMessageType == ChatMessageType.component;

  bool get isGlitterBomb => isComponentType && component?.type == ChatComponentType.glitterBomb;

  bool get isCircleInvitation => isComponentType && component?.type == ChatComponentType.circleInvite;

  bool get isSelfReacted => reactions.firstWhereOrNull((element) => element.hasReacted)?.hasReacted ?? false;

  bool get hasAnyReactions => reactionsCount > 0;

  List<ChatMessageReaction> get selfReactions => reactions.where((r) => r.hasReacted).toList();

  bool get hasPdf => attachments.any((a) => a.isPdf);

  bool get isAuthorModerator => [ChatRole.director, ChatRole.moderator].contains(member.role);

  bool get isUserMessage => chatMessageSender == ChatMessageSender.user;

  String formatSendAt(DateTime now) => createdAt?.formatSendMessage(now) ?? "";

  String formatSendAtDay(DateTime now) => createdAt?.formatMessageDay(now) ?? "";

  ChatMessage byUpdatingReaction(ChatMessageReaction reaction) {
    final newReactions = [...reactions]
      ..removeWhere((element) => element.reactionType == reaction.reactionType)
      ..add(reaction);
    return copyWith(
      reactions: newReactions,
    );
  }

  ChatMessage byUpdatingContent(String content) => copyWith(
        content: content,
      );

  ChatMessage byUpdatingChatMessageSender(User user) => copyWith(
        chatMessageSender: user.id == author.id ? ChatMessageSender.user : ChatMessageSender.friend,
      );

  ChatMessage byAddingAttachment(Attachment attachment) => copyWith(
        attachments: List.unmodifiable(attachments + [attachment]),
      );

  ChatMessage byRemovingAttachment(Attachment attachment) => copyWith(
        attachments: List.unmodifiable([...attachments]..remove(attachment)),
      );

  ChatMessage copyWith({
    Id? id,
    String? content,
    ChatMessage? repliedContent,
    List<ChatMessageReaction>? reactions,
    ChatMessageStatus? chatMessageStatus,
    ChatMessageType? chatMessageType,
    ChatMessageSender? chatMessageSender,
    User? author,
    List<ChatMention>? chatMention,
    String? createdAtString,
    ChatComponent? component,
    List<Id>? attachmentIds,
    List<Attachment>? attachments,
    List<Embed>? embeds,
    bool? isSent,
    ChatMember? member,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      repliedContent: repliedContent ?? this.repliedContent,
      reactions: reactions ?? this.reactions,
      chatMessageStatus: chatMessageStatus ?? this.chatMessageStatus,
      chatMessageType: chatMessageType ?? this.chatMessageType,
      chatMessageSender: chatMessageSender ?? this.chatMessageSender,
      author: author ?? this.author,
      chatMention: chatMention ?? this.chatMention,
      createdAtString: createdAtString ?? this.createdAtString,
      component: component ?? this.component,
      attachmentIds: attachmentIds ?? this.attachmentIds,
      attachments: attachments ?? this.attachments,
      embeds: embeds ?? this.embeds,
      member: member ?? this.member,
    );
  }
}

extension ChatMessageSenderMapper on List<ChatMessage> {
  List<ChatMessage> byUpdatingSender(User currentUser) =>
      map((it) => it.byUpdatingChatMessageSender(currentUser)).toList();
}
