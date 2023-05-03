import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item_with_avatar_button.dart';
import 'package:picnic_app/ui/widgets/picnic_rainbow_circular_border.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CirclesSearchResult extends StatelessWidget {
  const CirclesSearchResult({
    super.key,
    required this.circles,
    required this.onTapJoinButton,
    required this.onTapViewCircle,
  });

  final void Function(Circle circle) onTapJoinButton;
  final List<Circle> circles;
  final Function(Id) onTapViewCircle;

  static const _avatarSize = 48.0;
  static const _emojiSize = 24.0;

  static const _avatarBorderSize = 2.0;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final currentCircle = circles[index];
            final theme = PicnicTheme.of(context);
            final colors = theme.colors;
            final picnicAvatar = PicnicRainbowCircularBorder(
              childSize: _avatarSize,
              borderWidth: _avatarBorderSize,
              child: PicnicCircleAvatar(
                emoji: currentCircle.emoji,
                image: currentCircle.imageFile,
                emojiSize: _emojiSize,
                avatarSize: _avatarSize,
                isVerified: currentCircle.isVerified,
                bgColor: colors.blackAndWhite.shade200,
              ),
            );
            return PicnicListItemWithAvatarButton(
              onTapButton: () => onTapJoinButton(currentCircle),
              activeText: appLocalizations.joinedButtonActionTitle,
              title: currentCircle.name,
              passiveText: appLocalizations.joinButtonActionTitle,
              isActive: currentCircle.iJoined,
              onTapView: () => onTapViewCircle(currentCircle.id),
              showFollowButton: true,
              picnicAvatar: picnicAvatar,
            );
          },
          childCount: circles.length,
        ),
      );
}
