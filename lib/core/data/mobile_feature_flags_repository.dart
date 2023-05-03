import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';
import 'package:picnic_app/core/domain/repositories/feature_flags_repository.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';

class MobileFeatureFlagsRepository implements FeatureFlagsRepository {
  const MobileFeatureFlagsRepository(
    this._environmentConfigProvider,
  );

  final EnvironmentConfigProvider _environmentConfigProvider;

  @override
  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> getFeatureFlags() =>
      _environmentConfigProvider.getFeatureFlags();
}
