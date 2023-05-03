//ignore_for_file: unused-files, unused-code
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ThoughtPostActionBar extends StatelessWidget {
  const ThoughtPostActionBar({
    Key? key,
    this.showAddButton = false,
    this.showAddSound = true,
    this.postButtonEnabled = true,
    this.onTapPost,
    this.onTapAddField,
    this.onTapMusic,
  }) : super(key: key);

  final bool showAddButton;
  final bool showAddSound;
  final bool postButtonEnabled;
  final VoidCallback? onTapAddField;
  final VoidCallback? onTapPost;
  final VoidCallback? onTapMusic;

  static const _borderRadius = 40.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showAddButton)
          PicnicContainerIconButton(
            iconPath: Assets.images.add.path,
            radius: _borderRadius,
            onTap: onTapAddField,
          ),
        const Spacer(),
        if (showAddSound)
          PicnicContainerIconButton(
            iconPath: Assets.images.music.path,
            radius: _borderRadius,
            onTap: onTapMusic,
          ),
        const Gap(16),
        PicnicButton(
          title: appLocalizations.postAction,
          icon: Assets.images.send.path,
          onTap: postButtonEnabled ? onTapPost : null,
        ),
      ],
    );
  }
}
