import 'package:picnic_app/core/domain/model/device_system_info.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';

const androidPhotosPermissionSdkNumber = 32;

RuntimePermission permissionByImageSourceType(
  ImageSourceType type, {
  required DeviceSystemInfo info,
}) {
  switch (type) {
    case ImageSourceType.camera:
      return RuntimePermission.camera;
    case ImageSourceType.gallery:
      return info.isAndroid && info.androidSdk < androidPhotosPermissionSdkNumber
          ? RuntimePermission.gallery
          : RuntimePermission.photos;
  }
}
