import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_overlay_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PermissionErrorView extends StatelessWidget {
  const PermissionErrorView({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String description;
  final String imagePath;
  final VoidCallback? onTap;

  static const _circleOpacity = 0.1;
  static const _imageAvatarRadius = 40.0;
  static const _redAvatarRadius = 10.0;
  static const _crossHeight = 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final whiteColor = blackAndWhite.shade100;
    final greyColor = blackAndWhite.shade600;
    return Scaffold(
      backgroundColor: blackAndWhite.shade900,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const PicnicCameraOverlayView(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: whiteColor.withOpacity(_circleOpacity),
                      minRadius: _imageAvatarRadius,
                      maxRadius: _imageAvatarRadius,
                      child: Image.asset(imagePath),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      maxRadius: _redAvatarRadius,
                      minRadius: _redAvatarRadius,
                      child: Image.asset(
                        Assets.images.close.path,
                        color: whiteColor,
                        height: _crossHeight,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Text(
                  title,
                  style: theme.styles.subtitle40.copyWith(color: whiteColor),
                ),
                const Gap(8),
                Text(
                  description,
                  style: theme.styles.caption20.copyWith(color: greyColor),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                PicnicButton(
                  title: appLocalizations.goToSettingsAction,
                  onTap: onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
