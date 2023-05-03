import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart' as lib;
import 'package:picnic_app/core/domain/model/get_runtime_permission_status_failure.dart';
import 'package:picnic_app/core/domain/model/open_native_app_settings_failure.dart';
import 'package:picnic_app/core/domain/model/request_runtime_permission_failure.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';

class FlutterRuntimePermissionsRepository implements RuntimePermissionsRepository {
  const FlutterRuntimePermissionsRepository();

  @override
  Future<Either<GetRuntimePermissionStatusFailure, RuntimePermissionStatus>> getPermissionStatus(
    RuntimePermission permission,
  ) async {
    try {
      final status = await permission.libPermission.status;
      return success(status.domainStatus);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(GetRuntimePermissionStatusFailure.unknown(ex));
    }
  }

  @override
  Future<Either<RequestRuntimePermissionFailure, RuntimePermissionStatus>> requestRuntimePermission(
    RuntimePermission permission,
  ) async {
    try {
      return success((await permission.libPermission.request()).domainStatus);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(RequestRuntimePermissionFailure.unknown(ex));
    }
  }

  @override
  Future<Either<OpenNativeAppSettingsFailure, bool>> openNativeAppSettings() async {
    try {
      return success(await lib.openAppSettings());
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(OpenNativeAppSettingsFailure.unknown(ex));
    }
  }
}

extension _RuntimePermissionHandler on RuntimePermission {
  lib.Permission get libPermission {
    switch (this) {
      case RuntimePermission.notifications:
        return lib.Permission.notification;
      case RuntimePermission.camera:
        return lib.Permission.camera;
      case RuntimePermission.photos:
        return lib.Permission.photos;
      case RuntimePermission.gallery:
        if (Platform.isIOS) {
          return lib.Permission.photos;
        }
        return lib.Permission.storage;
      case RuntimePermission.microphone:
        return lib.Permission.microphone;
      case RuntimePermission.files:
        return lib.Permission.storage;
      case RuntimePermission.contacts:
        return lib.Permission.contacts;
    }
  }
}

extension _DomainStatus on lib.PermissionStatus {
  RuntimePermissionStatus get domainStatus {
    switch (this) {
      case lib.PermissionStatus.denied:
        return RuntimePermissionStatus.denied;
      case lib.PermissionStatus.granted:
        return RuntimePermissionStatus.granted;
      case lib.PermissionStatus.restricted:
        return RuntimePermissionStatus.restricted;
      case lib.PermissionStatus.limited:
        return RuntimePermissionStatus.limited;
      case lib.PermissionStatus.permanentlyDenied:
        return RuntimePermissionStatus.permanentlyDenied;
    }
  }
}
