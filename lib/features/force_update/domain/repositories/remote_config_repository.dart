import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/force_update/domain/model/fetch_min_app_version_failure.dart';

abstract class RemoteConfigRepository {
  Future<Either<FetchMinAppVersionFailure, String>> fetchMinAppVersion();
}
