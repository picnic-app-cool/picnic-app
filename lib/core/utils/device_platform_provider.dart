import 'dart:io';

import 'package:picnic_app/core/domain/device_platform.dart';

class DevicePlatformProvider {
  DevicePlatform get currentPlatform {
    if (Platform.isIOS) {
      return DevicePlatform.ios;
    } else if (Platform.isAndroid) {
      return DevicePlatform.android;
    } else if (Platform.isMacOS) {
      return DevicePlatform.macos;
    } else {
      return DevicePlatform.other;
    }
  }
}
