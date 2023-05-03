// ignore_for_file: unused-code, unused-files
import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item/chat_list_item.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SwipeItemDismissible extends StatelessWidget {
  const SwipeItemDismissible({
    required Key key,
    required this.chatListItem,
    required this.onTapConfirmLeaveChat,
  }) : super(key: key);

  final ChatListItem chatListItem;
  final Function(BasicChat) onTapConfirmLeaveChat;

  static const _iconSize = Size(24.0, 24.0);

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final deleteIcon = Image.asset(
      Assets.images.delete.path,
      width: _iconSize.width,
      height: _iconSize.height,
      color: colors.blackAndWhite.shade100,
    );
    return Dismissible(
      key: key!,
      resizeDuration: Duration.zero,
      movementDuration: Duration.zero,
      background: Container(
        alignment: Alignment.centerRight,
        color: colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: deleteIcon,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: chatListItem,
      confirmDismiss: (direction) async => confirmDismiss(),
    );
  }

  bool confirmDismiss() {
    onTapConfirmLeaveChat(chatListItem.model.chat);
    return false;
  }
}
