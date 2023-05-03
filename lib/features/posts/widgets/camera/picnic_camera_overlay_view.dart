import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_primary_record_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_flash_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_gallery_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_switch_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCameraOverlayView extends StatelessWidget {
  const PicnicCameraOverlayView({
    Key? key,
    this.onTapCameraSwitch,
    this.onTapRecord,
    this.onTapFlashSwitch,
    this.onTapOpenGallery,
  }) : super(key: key);

  final VoidCallback? onTapRecord;
  final VoidCallback? onTapCameraSwitch;
  final VoidCallback? onTapFlashSwitch;
  final VoidCallback? onTapOpenGallery;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PicnicAppBar(
            iconPathLeft: Assets.images.close.path,
            actions: [
              if (onTapOpenGallery != null)
                AspectRatio(
                  aspectRatio: 1.0,
                  child: PicnicCameraSecondaryFlashButton(onTap: () => onTapFlashSwitch?.call()),
                ),
            ],
            backButtonIconColor: colors.blackAndWhite.shade100,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onTapOpenGallery != null)
                  PicnicCameraSecondaryGalleryButton(onTap: onTapOpenGallery!)
                else
                  PicnicCameraSecondaryFlashButton(onTap: () => onTapFlashSwitch?.call()),
                PicnicCameraPrimaryRecordButton(onTap: () => onTapRecord?.call()),
                PicnicCameraSecondarySwitchButton(onTap: () => onTapCameraSwitch?.call()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
