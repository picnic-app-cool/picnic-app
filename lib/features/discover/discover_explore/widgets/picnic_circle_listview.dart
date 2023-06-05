import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item_with_avatar_button.dart';
import 'package:picnic_app/ui/widgets/picnic_square.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCircleListView extends StatelessWidget {
  const PicnicCircleListView({
    Key? key,
    required this.items,
    required this.onTapViewCircle,
    this.showSubtitle = true,
    this.showFollowButton = true,
  }) : super(key: key);

  final List<Circle> items;
  final Function(Id) onTapViewCircle;
  final bool showSubtitle;
  final bool showFollowButton;

  static const _paddingValue = 8.0;
  static const _paddingValueFull = 200.0;
  static const _highPadding = 24.0;
  static const _avatarSize = 48.0;
  static const _emojiSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final body0 = theme.styles.body0.copyWith(color: colors.darkBlue.shade700);

    return SizedBox(
      height: PicnicSquare.height + _paddingValueFull,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final circle = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: _paddingValue),
            child: PicnicListItemWithAvatarButton(
              subtitleStyle: body0,
              subtitle: showSubtitle ? circle.membersCount.formattingToStat() : null,
              onTapButton: () => onTapViewCircle(circle.id),
              activeText: appLocalizations.joinedButtonActionTitle,
              title: circle.name,
              passiveText: appLocalizations.joinButtonActionTitle,
              isActive: circle.iJoined,
              onTapView: () => onTapViewCircle(circle.id),
              showFollowButton: showFollowButton,
              picnicAvatar: PicnicCircleAvatar(
                emoji: circle.emoji,
                image: circle.imageFile,
                emojiSize: _emojiSize,
                avatarSize: _avatarSize,
                isVerified: circle.isVerified,
                bgColor: colors.blackAndWhite.shade200,
              ),
            ),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: _highPadding, vertical: _paddingValue),
        itemCount: items.length,
      ),
    );
  }
}
