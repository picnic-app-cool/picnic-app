import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/group_chat/widgets/group_chat_row.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_messages_list/chat_messages_list.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

class GroupChatMessagesList extends StatelessWidget {
  const GroupChatMessagesList({
    required this.messages,
    required this.loadMore,
    required this.onTapFriendAvatar,
    required this.onTapOwnAvatar,
    required this.chatMessageContentActions,
    required this.dragOffset,
    required this.now,
    super.key,
  });

  final PaginatedList<DisplayableChatMessage> messages;
  final Future<void> Function() loadMore;
  final Function(Id) onTapFriendAvatar;
  final VoidCallback onTapOwnAvatar;
  final ChatMessageContentActions chatMessageContentActions;
  final double dragOffset;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Column(
      children: [
        Flexible(
          child: ChatMessagesList(
            messages: messages,
            loadMore: loadMore,
            now: now,
            padding: const EdgeInsets.only(
              left: Constants.smallPadding,
              right: Constants.smallPadding,
              bottom: 25,
            ),
            itemBuilder: (context, displayableMessage) {
              return GroupChatRow(
                avatarBorderColor: _selectColor(theme, 0),
                isContinuationMessage: !displayableMessage.isFirstInGroup,
                isLastInTheGroup: displayableMessage.isLastInGroup,
                displayableMessage: displayableMessage,
                onTapFriendAvatar: (message) => onTapFriendAvatar(displayableMessage.chatMessage.authorId),
                onTapOwnAvatar: onTapOwnAvatar,
                chatMessageContentActions: chatMessageContentActions,
                dragOffset: dragOffset,
                now: now,
              );
            },
          ),
        ),
      ],
    );
  }

  ///The border color of the avatar for messages sent by "friends"
  Color _selectColor(PicnicThemeData theme, int index) {
    final colors = _avatarColors(theme);
    return colors[index % colors.length];
  }

  List<Color> _avatarColors(PicnicThemeData theme) => <MaterialColor>[
        theme.colors.purple,
        theme.colors.lightBlue,
        theme.colors.yellow,
      ];
}
