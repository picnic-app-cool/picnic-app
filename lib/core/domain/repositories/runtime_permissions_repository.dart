import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_runtime_permission_status_failure.dart';
import 'package:picnic_app/core/domain/model/open_native_app_settings_failure.dart';
import 'package:picnic_app/core/domain/model/request_runtime_permission_failure.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';

abstract class RuntimePermissionsRepository {
  Future<Either<GetRuntimePermissionStatusFailure, RuntimePermissionStatus>> getPermissionStatus(
    RuntimePermission permission,
  );

  Future<Either<RequestRuntimePermissionFailure, RuntimePermissionStatus>> requestRuntimePermission(
    RuntimePermission permission,
  );

  Future<Either<OpenNativeAppSettingsFailure, bool>> openNativeAppSettings();
}
