import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/domain/model/get_app_info_failure.dart';

abstract class AppInfoRepository {
  Future<Either<GetAppInfoFailure, AppInfo>> getAppInfo();
}
