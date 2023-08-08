import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/force_update/domain/use_case/fetch_min_app_version_use_case.dart';

class ShouldShowForceUpdateUseCase {
  const ShouldShowForceUpdateUseCase(
    this._fetchMinAppVersionUseCase,
    this._appInfoStore,
    this._setAppInfoUseCase,
  );

  final FetchMinAppVersionUseCase _fetchMinAppVersionUseCase;
  final AppInfoStore _appInfoStore;
  final SetAppInfoUseCase _setAppInfoUseCase;

  Future<bool> execute() async {
    final remoteAppVersion = await _getRemoteAppVersion();
    await _setAppInfoUseCase.execute();
    final appVersion = _appInfoStore.appInfo.appVersion;

    if (remoteAppVersion.isEmpty || appVersion.isEmpty) {
      return false;
    }

    final appVersionValue = _convertVersionToInt(appVersion);
    final remoteAppVersionValue = _convertVersionToInt(remoteAppVersion);

    return appVersionValue < remoteAppVersionValue;
  }

  Future<String> _getRemoteAppVersion() async {
    var remoteAppVersion = '';
    await _fetchMinAppVersionUseCase.execute().doOn(
          success: (remoteAppVersionResult) => remoteAppVersion = remoteAppVersionResult,
        );
    return remoteAppVersion;
  }

  int _convertVersionToInt(String appVersion) {
    return int.parse(appVersion.replaceAll(".", ""));
  }
}
