import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/use_cases/log_out_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/debug/domain/model/change_environment_failure.dart';
import 'package:picnic_app/features/debug/domain/use_cases/restart_app_use_case.dart';

class ChangeEnvironmentUseCase {
  const ChangeEnvironmentUseCase(
    this._logOutUseCase,
    this._restartAppUseCase,
    this._environmentProvider,
  );

  final LogOutUseCase _logOutUseCase;
  final RestartAppUseCase _restartAppUseCase;
  final EnvironmentConfigProvider _environmentProvider;

  Future<Either<ChangeEnvironmentFailure, Unit>> execute({
    required EnvironmentConfigSlug slug,
  }) {
    return _environmentProvider.changeEnvironment(slug).flatMap((_) {
      return _logOutUseCase.execute().mapFailure(ChangeEnvironmentFailure.unknown);
    }).flatMap((_) {
      return _restartAppUseCase.execute().mapFailure(ChangeEnvironmentFailure.unknown);
    });
  }
}
