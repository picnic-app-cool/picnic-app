import 'package:picnic_app/core/domain/model/device_system_info.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';

const androidPhotosPermissionSdkNumber = 32;

RuntimePermission permissionByMediaSourceType(
  MediaSourceType type, {
  required DeviceSystemInfo info,
}) {
  switch (type) {
    case MediaSourceType.gallery:
      return info.isAndroid && info.androidSdk < androidPhotosPermissionSdkNumber
          ? RuntimePermission.gallery
          : RuntimePermission.photos;
    case MediaSourceType.file:
      return RuntimePermission.files;
    case MediaSourceType.cameraImage:
    case MediaSourceType.cameraVideo:
      return RuntimePermission.camera;
  }
}
