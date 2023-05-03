import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_primary_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCameraPrimaryPauseButton extends StatelessWidget {
  const PicnicCameraPrimaryPauseButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  static const _pauseIconSize = 34.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    return PicnicCameraPrimaryButton(
      onTap: onTap,
      child: Image.asset(
        Assets.images.pause.path,
        height: _pauseIconSize,
        width: _pauseIconSize,
        color: blackAndWhite.shade100,
      ),
    );
  }
}
