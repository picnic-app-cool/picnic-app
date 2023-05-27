import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeedListHeader extends StatelessWidget {
  const FeedListHeader({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.emoji,
    required this.image,
    required this.onTapImage,
  }) : super(key: key);

  final VoidCallback onTapImage;
  final String title;
  final String subTitle;
  final String emoji;
  final String image;

  static const _topAvatarSize = 48.0;
  static const _containerHeight = 48.0;
  static const _emojiSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final titleTextStyle = theme.styles.subtitle40;
    final subTitleTextStyle = theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600);

    final circleAvatar = PicnicCircleAvatar(
      emoji: emoji,
      image: image,
      avatarSize: _topAvatarSize,
      emojiSize: _emojiSize,
      bgColor: Colors.white,
    );

    return SizedBox(
      height: _containerHeight,
      child: Row(
        children: [
          const Gap(8),
          InkWell(
            onTap: onTapImage,
            child: circleAvatar,
          ),
          const Gap(8),
          Expanded(
            child: Text(
              title,
              style: titleTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(4),
          Text(
            subTitle,
            style: subTitleTextStyle,
          ),
          const Gap(8),
        ],
      ),
    );
  }
}
