import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CircleListItem extends StatelessWidget {
  const CircleListItem({
    super.key,
    required this.circle,
    required this.onTap,
    this.onTapEnabled = true,
  });

  final Circle circle;
  final VoidCallback onTap;
  final bool onTapEnabled;
  static const _avatarSize = 40.0;
  static const _emojiSize = 20.0;
  static const _disabledInfoIconHeight = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return PicnicListItem(
      leftGap: 0,
      trailingGap: 0,
      title: circle.name,
      onTap: onTap,
      height: null,
      titleStyle: theme.styles.title10,
      trailing: onTapEnabled
          ? PicnicButton(
              title: appLocalizations.chooseAction,
              borderRadius: const PicnicButtonRadius.round(),
              onTap: onTap,
            )
          : PicnicButton(
              title: appLocalizations.disabledLabel,
              titleColor: blackAndWhite.shade600,
              color: blackAndWhite.shade300,
              suffix: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Image.asset(
                  Assets.images.info.path,
                  color: blackAndWhite.shade600,
                  height: _disabledInfoIconHeight,
                ),
              ),
              onTap: onTap,
            ),
      leading: PicnicCircleAvatar(
        emoji: circle.emoji,
        image: circle.imageFile,
        emojiSize: _emojiSize,
        avatarSize: _avatarSize,
        bgColor: theme.colors.green.shade200,
      ),
    );
  }
}
