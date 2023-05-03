import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCameraSecondarySendButton extends StatelessWidget {
  const PicnicCameraSecondarySendButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PicnicCameraSecondaryButton(
      onTap: onTap,
      icon: Assets.images.arrowRightThree.path,
      color: PicnicTheme.of(context).colors.green.shade500,
    );
  }
}
