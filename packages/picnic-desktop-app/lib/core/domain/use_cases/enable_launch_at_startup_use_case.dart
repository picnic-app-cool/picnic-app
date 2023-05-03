import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_desktop_app/core/domain/model/launch_at_startup_failure.dart';
import 'package:picnic_desktop_app/core/domain/repositories/launch_at_startup_repository.dart';

class EnableLaunchAtStartupUseCase {
  const EnableLaunchAtStartupUseCase(
    this._appInfoStore,
    this._launchAtStartupRepository,
  );

  final AppInfoStore _appInfoStore;
  final LaunchAtStartupRepository _launchAtStartupRepository;

  Future<Either<LaunchAtStartupFailure, Unit>> execute() =>
      _launchAtStartupRepository.enableLaunchAtStartup(_appInfoStore.appInfo);
}
