import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';

class ChatMessageContentClickable extends StatefulWidget {
  const ChatMessageContentClickable({
    required this.displayableMessage,
    required this.chatMessageContentActions,
    required this.chatStyle,
    this.isAuthorModerator = false,
  });

  final DisplayableChatMessage displayableMessage;
  final ChatMessageContentActions chatMessageContentActions;
  final PicnicChatStyle chatStyle;
  final bool isAuthorModerator;

  @override
  State<ChatMessageContentClickable> createState() => _ChatMessageContentClickableState();
}

class _ChatMessageContentClickableState extends State<ChatMessageContentClickable> {
  final _picnicMessageKey = GlobalKey();
  final _materialKey = GlobalKey();

  DisplayableChatMessage get displayableMessage => widget.displayableMessage;

  ChatMessageContentActions get chatMessageContentActions => widget.chatMessageContentActions;

  PicnicChatStyle get chatStyle => widget.chatStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _picnicMessageKey,
      onLongPressStart: (_) => _onLongPressStart(),
      onLongPress: _onHandleLongPress,
      onDoubleTap: _onDoubleTap,
      child: Hero(
        tag: displayableMessage.chatMessage.id,
        child: Material(
          key: _materialKey,
          type: MaterialType.transparency,
          child: ChatMessageContent(
            displayableMessage: displayableMessage,
            chatMessageContentActions: chatMessageContentActions,
            chatStyle: chatStyle,
            isAuthorModerator: widget.isAuthorModerator,
          ),
        ),
      ),
    );
  }

  void _onLongPressStart() {
    chatMessageContentActions.onMessageSelected(displayableMessage.chatMessage);
  }

  void _onHandleLongPress() {
    HapticFeedback.mediumImpact();
    final renderObject = _picnicMessageKey.currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      final rect = renderObject!.paintBounds.shift(offset);

      chatMessageContentActions.onMessageLongPress(
        MessageActionsOpenEvent(
          sourceLeft: rect.left,
          sourceTop: rect.top,
          sourceWidth: rect.width,
          sourceHeight: rect.height,
          displayableMessage: displayableMessage,
        ),
      );
    }
  }

  void _onDoubleTap() {
    chatMessageContentActions.onDoubleTapMessage(displayableMessage.chatMessage);
  }
}
