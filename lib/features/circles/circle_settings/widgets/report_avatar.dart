import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ReportAvatar extends StatelessWidget {
  const ReportAvatar({
    Key? key,
    required this.circleEmoji,
    required this.circleImage,
    required this.isResolved,
  }) : super(key: key);

  final String circleEmoji;
  final String circleImage;
  final bool isResolved;

  static const _avatarSize = 35.0;
  static const _emojiSize = 20.0;
  static const _unresolvedDotSize = 8.0;
  static const _unresolvedDotRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Stack(
      children: [
        PicnicCircleAvatar(
          emoji: circleEmoji,
          image: circleImage,
          avatarSize: _avatarSize,
          emojiSize: _emojiSize,
        ),
        if (!isResolved)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: _unresolvedDotSize,
                height: _unresolvedDotSize,
                decoration: BoxDecoration(
                  color: theme.colors.red,
                  borderRadius: BorderRadius.circular(_unresolvedDotRadius),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
