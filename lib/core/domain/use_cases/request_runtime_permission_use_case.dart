import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/request_runtime_permission_failure.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';

class RequestRuntimePermissionUseCase {
  const RequestRuntimePermissionUseCase(
    this._repository,
  );

  final RuntimePermissionsRepository _repository;

  Future<Either<RequestRuntimePermissionFailure, RuntimePermissionStatus>> execute({
    required RuntimePermission permission,
  }) =>
      _repository.requestRuntimePermission(permission);
}
