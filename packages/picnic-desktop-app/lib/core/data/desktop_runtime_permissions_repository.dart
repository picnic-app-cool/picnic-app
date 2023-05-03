import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/request_runtime_permission_failure.dart';
import 'package:picnic_app/core/domain/model/open_native_app_settings_failure.dart';
import 'package:picnic_app/core/domain/model/get_runtime_permission_status_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

// TODO implement permissions https://picnic-app.atlassian.net/browse/GS-5551
class DesktopRuntimePermissionsRepository implements RuntimePermissionsRepository {
  @override
  Future<Either<GetRuntimePermissionStatusFailure, RuntimePermissionStatus>> getPermissionStatus(
    RuntimePermission permission,
  ) async =>
      success(RuntimePermissionStatus.granted);

  // TODO implement app_settings https://picnic-app.atlassian.net/browse/GS-5797
  @override
  Future<Either<OpenNativeAppSettingsFailure, bool>> openNativeAppSettings() {
    // TODO: implement openNativeAppSettings
    throw UnimplementedError();
  }

  // TODO implement app_settings https://picnic-app.atlassian.net/browse/GS-5797
  @override
  Future<Either<RequestRuntimePermissionFailure, RuntimePermissionStatus>> requestRuntimePermission(
    RuntimePermission permission,
  ) async =>
      success(RuntimePermissionStatus.granted);
}
