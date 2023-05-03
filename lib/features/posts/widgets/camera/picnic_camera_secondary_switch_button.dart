import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicCameraSecondarySwitchButton extends StatelessWidget {
  const PicnicCameraSecondarySwitchButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PicnicCameraSecondaryButton(
      onTap: onTap,
      icon: Assets.images.switchCamera.path,
    );
  }
}
