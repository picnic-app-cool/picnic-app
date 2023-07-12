import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_rectangle_avatar.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessageContentPostSummary extends StatelessWidget {
  const ChatMessageContentPostSummary({
    required this.post,
  });

  final Post post;
  static const _textContentPadding = EdgeInsets.only(
    left: 3,
  );

  static const _avatarSize = 28.0;
  static const _emojiSize = 18.0;
  static const _verifiedBadgeSize = 14.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final circle = post.circle;
    final circleEmoji = circle.emoji;
    final circleImage = circle.imageFile;

    final subtitle0 = styles.subtitle0;
    final circleNameStyle = subtitle0.copyWith(color: colors.darkBlue.shade600);
    final authorStyle = subtitle0.copyWith(color: colors.darkBlue.shade500);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PicnicCircleRectangleAvatar(
          bgColor: PicnicColors.ultraPaleGrey,
          borderColor: colors.darkBlue.shade300,
          avatarSize: _avatarSize,
          emojiSize: _emojiSize,
          verifiedBadgeSize: _verifiedBadgeSize,
          image: circleImage,
          emoji: circleEmoji,
          isVerified: circle.isVerified,
        ),
        Expanded(
          child: Padding(
            padding: _textContentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.circle.name,
                  style: circleNameStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  post.author.username.formattedUsername,
                  style: authorStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
