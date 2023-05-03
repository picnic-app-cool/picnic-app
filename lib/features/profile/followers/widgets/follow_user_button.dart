import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class FollowUserButton extends StatelessWidget {
  const FollowUserButton({
    required this.onTapToggleFollow,
    this.isFollowing = false,
    this.followingColor,
    this.notFollowingColor,
  });

  final VoidCallback? onTapToggleFollow;
  final bool isFollowing;
  final Color? followingColor;
  final Color? notFollowingColor;

  static const _notFollowingBorderWidth = 2.0;
  static const _followingBorderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final followingColor = this.followingColor ?? colors.pink.shade500;
    final notFollowingColor = this.notFollowingColor ?? colors.green;

    return PicnicButton(
      title: isFollowing ? appLocalizations.followingAction : appLocalizations.followAction,
      style: PicnicButtonStyle.outlined,
      color: isFollowing ? Colors.transparent : notFollowingColor,
      titleColor: isFollowing ? followingColor : colors.blackAndWhite.shade100,
      onTap: onTapToggleFollow,
      borderWidth: isFollowing ? _notFollowingBorderWidth : _followingBorderWidth,
      borderColor: isFollowing ? followingColor : notFollowingColor,
    );
  }
}
