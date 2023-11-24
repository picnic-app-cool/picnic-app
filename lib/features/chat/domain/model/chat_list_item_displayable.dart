//ignore_for_file: nullable_field_in_domain_entity, forbidden_import_in_domain
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';

class ChatListItemDisplayable extends Equatable {
  const ChatListItemDisplayable({
    required this.chat,
    required this.title,
    this.circle,
  });

  const ChatListItemDisplayable.empty()
      : chat = const BasicChat.empty(),
        title = const BadgedTitleDisplayable.empty(),
        circle = null;

  final BasicChat chat;
  final BadgedTitleDisplayable title;
  final BasicCircle? circle;

  @override
  List<Object?> get props => [
        chat,
        title,
        circle,
      ];

  ChatListItemDisplayable copyWith({
    BasicChat? chat,
    BadgedTitleDisplayable? title,
    BasicCircle? circle,
  }) {
    return ChatListItemDisplayable(
      chat: chat ?? this.chat,
      title: title ?? this.title,
      circle: circle ?? this.circle,
    );
  }
}

extension BasicChatToChatListItemDisplayableMapper on BasicChat {
  ChatListItemDisplayable toChatListItemDisplayable(Id currentUserId) {
    final emptyPlaceholder = BadgedTitleDisplayable(name: name);
    final title = chatType == ChatType.single
        ? participants //
                .firstWhereOrNull((user) => user.id != currentUserId)
                ?.toBadgedAuthorDisplayable() ??
            emptyPlaceholder
        : emptyPlaceholder;

    return ChatListItemDisplayable(
      chat: this,
      title: title,
    );
  }
}

extension ChatToChatListItemDisplayableMapper on Chat {
  ChatListItemDisplayable toChatListItemDisplayable(Id currentUserId) {
    final title = chatType == ChatType.single
        ? participants //
                .firstWhereOrNull((user) => user.id != currentUserId)
                ?.toBadgedAuthorDisplayable() ??
            const BadgedTitleDisplayable.empty()
        : BadgedTitleDisplayable(name: name);

    return ChatListItemDisplayable(
      chat: toBasicChat(),
      circle: circle,
      title: title,
    );
  }
}
