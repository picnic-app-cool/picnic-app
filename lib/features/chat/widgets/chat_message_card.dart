import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    required this.message,
    required this.isSameUser,
    required this.child,
    this.contentPadding,
    this.onTap,
    super.key,
  });

  final ChatMessage message;
  final bool isSameUser;
  final Widget child;
  final EdgeInsets? contentPadding;
  final VoidCallback? onTap;

  static const _borderRadius = 16.0;

  static const _blurRadius = 30.0;
  static const _shadowOpacity = 0.05;

  static const _borderRadiusIsSameUser = BorderRadius.all(
    Radius.circular(
      _borderRadius,
    ),
  );

  static const _padding = EdgeInsets.all(10.0);

  BorderRadius get _borderRadiusSender {
    double borderRadiusTopLeft;
    double borderRadiusTopRight;
    switch (message.chatMessageSender) {
      case ChatMessageSender.user:
        borderRadiusTopLeft = _borderRadius;
        borderRadiusTopRight = 0.0;
        break;
      case ChatMessageSender.friend:
        borderRadiusTopLeft = 0.0;
        borderRadiusTopRight = _borderRadius;
    }
    return BorderRadius.only(
      bottomLeft: const Radius.circular(_borderRadius),
      bottomRight: const Radius.circular(_borderRadius),
      topLeft: Radius.circular(borderRadiusTopLeft),
      topRight: Radius.circular(borderRadiusTopRight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;

    List<BoxShadow>? boxShadow;
    Color backgroundColor;
    switch (message.chatMessageSender) {
      case ChatMessageSender.user:
        backgroundColor = colors.blue.shade200;
        break;
      case ChatMessageSender.friend:
        boxShadow = [
          BoxShadow(
            blurRadius: _blurRadius,
            color: blackAndWhite.shade900.withOpacity(_shadowOpacity),
            offset: const Offset(0, 10),
          ),
        ];
        backgroundColor = colors.blackAndWhite.shade100;
    }

    final borderRadius = isSameUser ? _borderRadiusIsSameUser : _borderRadiusSender;

    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: contentPadding ?? _padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
