import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_desktop_app/core/domain/model/launch_at_startup_failure.dart';

abstract class LaunchAtStartupRepository {
  Future<Either<LaunchAtStartupFailure, Unit>> enableLaunchAtStartup(
    AppInfo appInfo,
  );
}
