import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/domain/repositories/app_badge_repository.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';

class FlutterAppBadgeRepository implements AppBadgeRepository {
  const FlutterAppBadgeRepository(
    this._devicePlatformProvider,
  );

  final DevicePlatformProvider _devicePlatformProvider;

  @override
  Future<void> updateAppBadgeCount(int count) async {
    switch (_devicePlatformProvider.currentPlatform) {
      case DevicePlatform.ios:
      case DevicePlatform.android:
      case DevicePlatform.macos:
        return _updateAppBadgeCount(count);
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.other:
        break;
    }
  }

  Future<void> _updateAppBadgeCount(int count) => FlutterAppBadger.updateBadgeCount(count);
}
