import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';

class ChatMessageContentCard extends StatelessWidget {
  const ChatMessageContentCard({
    required this.displayableMessage,
    required this.chatStyle,
    required this.child,
  });

  final DisplayableChatMessage displayableMessage;
  final PicnicChatStyle chatStyle;
  final Widget child;

  static const _borderRadius = 16.0;
  static const _borderRadiusIsSameUser = BorderRadius.all(
    Radius.circular(
      _borderRadius,
    ),
  );

  static const _padding = EdgeInsets.zero;

  bool get _isSameUser => !displayableMessage.isFirstInGroup;

  BorderRadius get _borderRadiusSender {
    double borderRadiusBottomLeft;
    double borderRadiusBottomRight;
    switch (displayableMessage.chatMessage.chatMessageSender) {
      case ChatMessageSender.user:
        borderRadiusBottomLeft = _borderRadius;
        borderRadiusBottomRight = 0.0;
        break;
      case ChatMessageSender.friend:
        borderRadiusBottomLeft = 0.0;
        borderRadiusBottomRight = _borderRadius;
    }
    return BorderRadius.only(
      topLeft: const Radius.circular(_borderRadius),
      topRight: const Radius.circular(_borderRadius),
      bottomLeft: Radius.circular(borderRadiusBottomLeft),
      bottomRight: Radius.circular(borderRadiusBottomRight),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? boxShadow;
    var backgroundColor = displayableMessage.chatMessage.isUserMessage
        ? chatStyle.userCardBackgroundColor
        : chatStyle.friendCardBackgroundColor;

    final borderRadius = _isSameUser ? _borderRadiusIsSameUser : _borderRadiusSender;

    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
