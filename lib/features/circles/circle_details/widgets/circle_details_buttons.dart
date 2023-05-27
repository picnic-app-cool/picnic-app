import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CircleDetailsButtons extends StatelessWidget {
  const CircleDetailsButtons({
    Key? key,
    required this.onTapCircleChat,
    required this.onTapJoin,
    required this.onTapSeedHolders,
    required this.isMember,
    required this.showSeedHolders,
    required this.onTapPost,
    required this.onTapInviteUsers,
    required this.isPostingEnabled,
    required this.hasPermissionToManageCircle,
    required this.onTapViewPods,
  }) : super(key: key);

  final VoidCallback onTapCircleChat;
  final VoidCallback onTapViewPods;
  final VoidCallback onTapJoin;
  final VoidCallback onTapPost;
  final VoidCallback onTapInviteUsers;

  final bool isPostingEnabled;

  final bool hasPermissionToManageCircle;

  final VoidCallback onTapSeedHolders;
  final bool isMember;
  final bool showSeedHolders;
  static const padding = EdgeInsets.symmetric(horizontal: 48, vertical: 14);

  static const _borderWidth = 2.0;
  static const _rowSpacing = 8.0;

  static const _inviteButtonRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final whiteColor = blackAndWhite.shade100;
    final blueColor = theme.colors.blue.shade500;

    var _title = '';
    var _onTap = onTapJoin;
    switch (isMember) {
      case true:
        _title = appLocalizations.postAction;
        _onTap = onTapPost;
        break;
      case false:
        _onTap = onTapJoin;
        _title = appLocalizations.joinAction;
    }

    final darkBlue = theme.colors.darkBlue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PicnicButton(
          icon: Assets.images.wand.path,
          title: appLocalizations.pods,
          borderRadius: const PicnicButtonRadius.round(),
          color: theme.colors.purple.shade500,
          padding: padding,
          titleColor: whiteColor,
          onTap: onTapViewPods,
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: PicnicButton(
                title: appLocalizations.chatLabel,
                borderRadius: const PicnicButtonRadius.round(),
                color: darkBlue.shade300,
                padding: padding,
                titleColor: darkBlue.shade800,
                onTap: onTapCircleChat,
              ),
            ),
            const Gap(_rowSpacing),
            Expanded(
              child: PicnicButton(
                title: _title,
                borderRadius: const PicnicButtonRadius.round(),
                color: blueColor,
                borderColor: blueColor,
                padding: padding,
                borderWidth: _borderWidth,
                titleColor: whiteColor,
                onTap: _onTap,
                opacity: isPostingEnabled || !isMember ? 1 : PicnicButton.opacityDisabled,
              ),
            ),
            if (isMember && hasPermissionToManageCircle) ...[
              const Gap(_rowSpacing),
              PicnicContainerIconButton(
                radius: _inviteButtonRadius,
                iconPath: Assets.images.addUser.path,
                iconTintColor: darkBlue.shade800,
                onTap: onTapInviteUsers,
                buttonColor: darkBlue.shade300,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
