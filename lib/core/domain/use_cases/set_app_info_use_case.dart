import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_app_info_failure.dart';
import 'package:picnic_app/core/domain/repositories/app_info_repository.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class SetAppInfoUseCase {
  const SetAppInfoUseCase(this._appInfoRepository, this._appInfoStore);

  final AppInfoRepository _appInfoRepository;
  final AppInfoStore _appInfoStore;

  Future<Either<GetAppInfoFailure, Unit>> execute() => _appInfoRepository
      .getAppInfo()
      .doOn(success: (appInfo) => _appInfoStore.appInfo = appInfo)
      .mapSuccess((_) => unit);
}
