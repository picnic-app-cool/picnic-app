import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/open_native_app_settings_failure.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';

class OpenNativeAppSettingsUseCase {
  const OpenNativeAppSettingsUseCase(this._repository);

  final RuntimePermissionsRepository _repository;

  Future<Either<OpenNativeAppSettingsFailure, bool>> execute() => _repository.openNativeAppSettings();
}
