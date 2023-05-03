import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_primary_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCameraPrimaryRecordButton extends StatelessWidget {
  const PicnicCameraPrimaryRecordButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    return PicnicCameraPrimaryButton(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: blackAndWhite.shade100,
        ),
      ),
    );
  }
}
