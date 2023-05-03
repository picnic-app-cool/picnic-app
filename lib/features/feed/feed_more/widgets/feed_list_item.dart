import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeedListItem extends StatelessWidget {
  const FeedListItem({
    super.key,
    required this.feed,
    required this.onTap,
  });

  final Feed feed;
  final VoidCallback onTap;
  static const _avatarSize = 40.0;
  static const _emojiSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final feedMembersCount = feed.membersCount;
    final feedMembersCountFormatted = feedMembersCount.formattingToStat().toLowerCase();
    final subtitle = feedMembersCount == -1 ? '' : '$feedMembersCountFormatted ${appLocalizations.membersLabel}';
    final blackAndWhite = theme.colors.blackAndWhite;
    return PicnicListItem(
      leftGap: 0,
      trailingGap: 0,
      title: feed.name,
      onTap: onTap,
      height: null,
      titleStyle: theme.styles.title20,
      trailing: Text(
        subtitle,
        style: theme.styles.caption10.copyWith(color: blackAndWhite.shade600),
      ),
      leading: PicnicCircleAvatar(
        emoji: feed.emoji,
        image: feed.imageFile,
        avatarSize: _avatarSize,
        emojiSize: _emojiSize,
        bgColor: blackAndWhite.shade200,
      ),
    );
  }
}
