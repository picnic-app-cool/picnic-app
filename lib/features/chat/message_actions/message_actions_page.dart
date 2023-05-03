import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presentation_model.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presenter.dart';
import 'package:picnic_app/features/chat/message_actions/popups/message_default_popup.dart';
import 'package:picnic_app/features/chat/message_actions/popups/message_not_sent_popup.dart';
import 'package:picnic_app/features/chat/message_actions/reaction_picker.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';

//ignore_for_file: too_many_page_file_members
class MessageActionsPage extends StatefulWidget with HasPresenter<MessageActionsPresenter> {
  const MessageActionsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final MessageActionsPresenter presenter;

  @override
  State<MessageActionsPage> createState() => _MessageActionsPageState();
}

class _MessageActionsPageState extends State<MessageActionsPage>
    with PresenterStateMixin<MessageActionsViewModel, MessageActionsPresenter, MessageActionsPage> {
  @override
  Widget build(BuildContext context) {
    final event = state.event;
    final displayableMessage = event.displayableMessage;
    final message = displayableMessage.chatMessage;
    final screenHeight = MediaQuery.of(context).size.height;

    final picnicMessage = Hero(
      tag: message.id,
      child: Material(
        type: MaterialType.transparency,
        child: ChatMessageContent(
          displayableMessage: displayableMessage,
          chatMessageContentActions: ChatMessageContentActions.empty(),
          chatStyle: PicnicChatStyle.fromContext(
            context,
            ChatType.single,
          ),
        ),
      ),
    );

    Widget _getPopup({required List<PopUpMenuItem> menuItems, required ValueChanged<PopUpMenuItem> onTapMenuItem}) =>
        message.isNotSent
            ? MessageNotSentPopup(
                menuItems: menuItems,
                onTapMenuItem: onTapMenuItem,
              )
            : MessageDefaultPopup(
                menuItems: menuItems,
                onTapMenuItem: onTapMenuItem,
              );

    var columnAxisAlignment = CrossAxisAlignment.end;
    var popupPadding = EdgeInsets.zero;

    if (message.chatMessageSender == ChatMessageSender.friend) {
      popupPadding = EdgeInsets.only(
        left: event.sourceLeft,
      );
      columnAxisAlignment = CrossAxisAlignment.start;
    }

    return LightStatusBar(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSingleChildLayout(
          delegate: _RelativeLayoutDelegate(
            sourceTop: event.sourceTop,
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: columnAxisAlignment,
              children: [
                if (event.sourceHeight < screenHeight) ...[
                  ReactionPicker(
                    onReactionPressed: presenter.onTapReaction,
                    selectedReactions: message.selfReactions,
                  ),
                  const Gap(10),
                ],
                Padding(
                  padding: EdgeInsets.only(
                    left: event.sourceLeft,
                  ),
                  child: (event.sourceWidth != 0 && event.sourceHeight != 0)
                      ? SizedBox(
                          width: event.sourceWidth,
                          height: event.sourceHeight,
                          child: picnicMessage,
                        )
                      : picnicMessage,
                ),
                const Gap(10),
                if (event.sourceHeight >= screenHeight) ...[
                  ReactionPicker(
                    onReactionPressed: presenter.onTapReaction,
                    selectedReactions: message.selfReactions,
                  ),
                  const Gap(10),
                ],
                Padding(
                  padding: popupPadding,
                  //ignore: avoid-returning-widgets
                  child: _getPopup(
                    menuItems: state.popupMenuItems,
                    onTapMenuItem: presenter.onTapMenuItem,
                  ),
                ),
                const Gap(60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RelativeLayoutDelegate extends SingleChildLayoutDelegate {
  _RelativeLayoutDelegate({
    required this.sourceTop,
  });

  final double sourceTop;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double offsetY = math.max(0, sourceTop);

    final maxOffsetY = size.height - childSize.height;

    if (offsetY > maxOffsetY) {
      offsetY = maxOffsetY;
    }
    return Offset(0, offsetY);
  }

  @override
  bool shouldRelayout(_RelativeLayoutDelegate oldDelegate) {
    return oldDelegate.sourceTop != sourceTop;
  }
}
