import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicCameraSecondaryGalleryButton extends StatelessWidget {
  const PicnicCameraSecondaryGalleryButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PicnicCameraSecondaryButton(
      onTap: onTap,
      icon: Assets.images.image.path,
    );
  }
}
