import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicCameraSecondaryFlashButton extends StatelessWidget {
  const PicnicCameraSecondaryFlashButton({
    super.key,
    required this.onTap,
    this.enableFlash = true,
  });

  final VoidCallback onTap;
  final bool enableFlash;

  @override
  Widget build(BuildContext context) {
    return PicnicCameraSecondaryButton(
      onTap: onTap,
      icon: enableFlash ? Assets.images.lightning.path : Assets.images.lightningOff.path,
    );
  }
}
