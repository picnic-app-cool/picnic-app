import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_desktop_app/core/domain/model/launch_at_startup_failure.dart';
import 'package:picnic_desktop_app/core/domain/repositories/launch_at_startup_repository.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

class DesktopLaunchAtStartupRepository implements LaunchAtStartupRepository {
  const DesktopLaunchAtStartupRepository();

  @override
  Future<Either<LaunchAtStartupFailure, Unit>> enableLaunchAtStartup(
    AppInfo appInfo,
  ) async {
    try {
      await _enableLaunchAtStartup(appInfo.appName);
      return success(unit);
    } catch (ex) {
      return left(const LaunchAtStartupFailure.unknown());
    }
  }

  Future<void> _enableLaunchAtStartup(String appName) async {
    launchAtStartup.setup(
      appName: appName,
      appPath: Platform.resolvedExecutable,
    );

    await launchAtStartup.enable();
  }
}
