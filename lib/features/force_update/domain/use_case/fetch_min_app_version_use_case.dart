import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/force_update/domain/model/fetch_min_app_version_failure.dart';
import 'package:picnic_app/features/force_update/domain/repositories/remote_config_repository.dart';

class FetchMinAppVersionUseCase {
  const FetchMinAppVersionUseCase(this._remoteConfigRepository);

  final RemoteConfigRepository _remoteConfigRepository;

  Future<Either<FetchMinAppVersionFailure, String>> execute() async {
    return _remoteConfigRepository.fetchMinAppVersion();
  }
}
