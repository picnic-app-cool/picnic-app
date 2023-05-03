import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/camera_permission_info.dart';
import 'package:picnic_app/features/posts/post_creation_index/widgets/camera_loading_preview.dart';
import 'package:picnic_app/features/posts/post_creation_index/widgets/permission_error_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class CameraPermissionInfoView extends StatelessWidget {
  const CameraPermissionInfoView({
    Key? key,
    this.onTapGoToSettings,
    required this.cameraPermissionInfo,
  }) : super(key: key);

  final CameraPermissionInfo cameraPermissionInfo;
  final VoidCallback? onTapGoToSettings;

  @override
  Widget build(BuildContext context) {
    if (cameraPermissionInfo.isCameraLoading) {
      return const CameraLoadingPreview();
    }
    return PermissionErrorView(
      imagePath:
          cameraPermissionInfo.isCameraPermissionError ? Assets.images.camera.path : Assets.images.microphone.path,
      title: appLocalizations.dynamicPermissionTitle(
        cameraPermissionInfo.isCameraPermissionError
            ? appLocalizations.imagePickerAlertOptionCamera
            : appLocalizations.microphoneLabel,
      ),
      description: appLocalizations.dynamicPermissionDesc(
        cameraPermissionInfo.isCameraPermissionError
            ? appLocalizations.imagePickerAlertOptionCamera
            : appLocalizations.microphoneLabel,
      ),
      onTap: onTapGoToSettings,
    );
  }
}
