import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/domain/model/device_system_info.dart';
import 'package:picnic_app/core/domain/model/get_app_info_failure.dart';
import 'package:picnic_app/core/domain/model/version_control_info.dart';
import 'package:picnic_app/core/domain/repositories/app_info_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class DeviceAppInfoRepository implements AppInfoRepository {
  const DeviceAppInfoRepository();

  static const _buildSourceEnvironmentKey = 'BUILD_SOURCE_NAME';
  static const _versionControlBranchEnvironmentKey = 'BUILD_SOURCE_BRANCH';
  static const _versionControlCommitEnvironmentKey = 'BUILD_SOURCE_COMMIT';

  @override
  // ignore: long-method
  Future<Either<GetAppInfoFailure, AppInfo>> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    var device = '';
    var model = '';
    var os = '';
    var sdk = 0;
    var platform = DevicePlatform.other;

    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      device = deviceInfo.device;
      model = deviceInfo.model;
      os = deviceInfo.version.release;
      sdk = deviceInfo.version.sdkInt;
      platform = DevicePlatform.android;
    }
    if (Platform.isIOS) {
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      device = deviceInfo.name ?? '';
      os = deviceInfo.systemVersion ?? '';
      platform = DevicePlatform.ios;
    }
    if (Platform.isMacOS) {
      final deviceInfo = await DeviceInfoPlugin().macOsInfo;
      device = deviceInfo.model;
      os = deviceInfo.osRelease;
      platform = DevicePlatform.macos;
    }
    if (Platform.isWindows) {
      final deviceInfo = await DeviceInfoPlugin().windowsInfo;
      device = deviceInfo.productName;
      platform = DevicePlatform.windows;
    }
    if (Platform.isLinux) {
      final deviceInfo = await DeviceInfoPlugin().linuxInfo;
      device = deviceInfo.name;
      os = deviceInfo.id;
      platform = DevicePlatform.linux;
    }

    var buildSource = const String.fromEnvironment(_buildSourceEnvironmentKey);
    var buildBranch = const String.fromEnvironment(_versionControlBranchEnvironmentKey);
    var buildCommit = const String.fromEnvironment(_versionControlCommitEnvironmentKey);

    return success(
      AppInfo(
        buildSource: buildSource,
        buildNumber: packageInfo.buildNumber,
        appVersion: packageInfo.version,
        packageName: packageInfo.packageName,
        appName: packageInfo.appName,
        deviceInfo: DeviceSystemInfo(
          platform: platform,
          device: '$device $model',
          osVersion: os,
          androidSdk: sdk,
        ),
        versionControlInfo: VersionControlInfo(
          branch: buildBranch,
          commit: buildCommit,
        ),
      ),
    );
  }
}
