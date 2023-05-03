import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicChatStyle {
  PicnicChatStyle._({
    required this.authorStyle,
    required this.userTextStyle,
    required this.friendTextStyle,
    required this.userCardBackgroundColor,
    required this.friendCardBackgroundColor,
    required this.userReplyBackgroundColor,
    required this.userReplyBackgroundLeftColor,
    required this.friendReplyBackgroundColor,
    required this.friendReplyBackgroundLeftColor,
    required this.shadowColor,
    required this.friendReplyTextColor,
    required this.userReplyTextColor,
    required this.linkPreviewBackgroundLeftColor,
  });

  //ignore: long-method
  factory PicnicChatStyle.fromContext(
    BuildContext context,
    ChatType chatType,
  ) {
    final theme = PicnicTheme.of(context);

    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final textStyleCaption10 = theme.styles.caption10;
    final textStyleBody10 = theme.styles.body10;
    const chatBlue = Color(0xFF43A3FC);
    const chatBrightBlue = Color(0xFF4CA7FB);

    Color friendReplyBackgroundLeftColor;
    Color userReplyBackgroundColor;

    switch (chatType) {
      case ChatType.single:
        friendReplyBackgroundLeftColor = colors.blue.shade200;
        userReplyBackgroundColor = chatBrightBlue;
        break;
      case ChatType.group:
        friendReplyBackgroundLeftColor = colors.blue.shade200;
        userReplyBackgroundColor = chatBrightBlue;
        break;
      case ChatType.circle:
        friendReplyBackgroundLeftColor = chatBrightBlue;
        userReplyBackgroundColor = chatBrightBlue;
        break;
    }

    const friendCardBackgroundColorOpacity = 0.05;
    const userReplyTextColorOpacity = 0.6;
    const friendReplyTextColorOpacity = 0.6;

    return PicnicChatStyle._(
      authorStyle: textStyleBody10.copyWith(
        color: chatBlue,
      ),
      userTextStyle: textStyleCaption10.copyWith(
        color: Colors.white,
      ),
      friendTextStyle: textStyleCaption10.copyWith(
        color: colors.blackAndWhite.shade800,
      ),
      userCardBackgroundColor: chatBlue,
      friendCardBackgroundColor: colors.blue.shade600.withOpacity(friendCardBackgroundColorOpacity),
      userReplyBackgroundColor: userReplyBackgroundColor,
      userReplyBackgroundLeftColor: blackAndWhite.shade100,
      friendReplyBackgroundColor: const Color(0xFFF5F5F5),
      friendReplyBackgroundLeftColor: friendReplyBackgroundLeftColor,
      shadowColor: colors.blackAndWhite.shade900,
      userReplyTextColor: blackAndWhite.shade100.withOpacity(userReplyTextColorOpacity),
      friendReplyTextColor: Colors.black.withOpacity(friendReplyTextColorOpacity),
      linkPreviewBackgroundLeftColor: chatBlue,
    );
  }

  @visibleForTesting
  factory PicnicChatStyle.forTesting() {
    return PicnicChatStyle._(
      authorStyle: const TextStyle(),
      userTextStyle: const TextStyle(),
      friendTextStyle: const TextStyle(),
      userCardBackgroundColor: Colors.black,
      friendCardBackgroundColor: Colors.black,
      userReplyBackgroundColor: Colors.black,
      userReplyBackgroundLeftColor: Colors.black,
      friendReplyBackgroundColor: Colors.black,
      friendReplyBackgroundLeftColor: Colors.black,
      shadowColor: Colors.black,
      userReplyTextColor: Colors.black,
      friendReplyTextColor: Colors.black,
      linkPreviewBackgroundLeftColor: Colors.black,
    );
  }

  final TextStyle authorStyle;
  final TextStyle userTextStyle;
  final TextStyle friendTextStyle;
  final Color userCardBackgroundColor;
  final Color friendCardBackgroundColor;
  final Color userReplyBackgroundColor;
  final Color userReplyBackgroundLeftColor;
  final Color friendReplyBackgroundColor;
  final Color friendReplyBackgroundLeftColor;
  final Color shadowColor;
  final Color userReplyTextColor;
  final Color friendReplyTextColor;
  final Color linkPreviewBackgroundLeftColor;
}
