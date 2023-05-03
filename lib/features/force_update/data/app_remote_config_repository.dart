import 'package:dartz/dartz.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:picnic_app/constants/firebase_remote_config_keys.dart';
import 'package:picnic_app/features/force_update/domain/model/fetch_min_app_version_failure.dart';
import 'package:picnic_app/features/force_update/domain/repositories/remote_config_repository.dart';

class AppRemoteConfigRepository implements RemoteConfigRepository {
  AppRemoteConfigRepository();

  @override
  Future<Either<FetchMinAppVersionFailure, String>> fetchMinAppVersion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    final minAppVersion = remoteConfig.getString(FirebaseRemoteConfigKeys.minAppVersion);
    return minAppVersion.isNotEmpty ? Right(minAppVersion) : const Left(FetchMinAppVersionFailure.unknown());
  }
}
