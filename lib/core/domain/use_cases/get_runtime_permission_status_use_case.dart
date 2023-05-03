import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_runtime_permission_status_failure.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';

class GetRuntimePermissionStatusUseCase {
  const GetRuntimePermissionStatusUseCase(
    this._repository,
  );

  final RuntimePermissionsRepository _repository;

  Future<Either<GetRuntimePermissionStatusFailure, RuntimePermissionStatus>> execute({
    required RuntimePermission permission,
  }) async =>
      _repository.getPermissionStatus(permission);
}
