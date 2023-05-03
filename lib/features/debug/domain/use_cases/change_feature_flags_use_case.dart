import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/features/debug/domain/model/change_feature_flags_failure.dart';

class ChangeFeatureFlagsUseCase {
  const ChangeFeatureFlagsUseCase(
    this._environmentProvider,
  );

  final EnvironmentConfigProvider _environmentProvider;

  Future<Either<ChangeFeatureFlagsFailure, Unit>> execute(FeatureFlags featureFlags) =>
      _environmentProvider.changeFeatureFlags(featureFlags);
}
