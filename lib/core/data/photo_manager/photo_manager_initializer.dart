import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';

class PhotoManagerInitializer implements LibraryInitializer {
  const PhotoManagerInitializer(this._platformProvider);

  final DevicePlatformProvider _platformProvider;

  @override
  Future<void> init() async {
    switch (_platformProvider.currentPlatform) {
      case DevicePlatform.ios:
      case DevicePlatform.android:
      case DevicePlatform.macos:
        await PhotoManager.setIgnorePermissionCheck(false);
        await PhotoManager.clearFileCache();
        break;
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.other:
        break;
    }
  }
}
