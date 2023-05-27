import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class AvatarEditButton extends StatelessWidget {
  const AvatarEditButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  static const _iconSize = 15.0;
  static const _buttonSize = 28.0;

  @override
  Widget build(BuildContext context) {
    return PicnicIconButton(
      icon: Assets.images.repeat.path,
      iconSize: _iconSize,
      size: _buttonSize,
      onTap: onTap,
      color: PicnicTheme.of(context).colors.blue,
    );
  }
}
