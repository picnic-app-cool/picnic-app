import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';
import 'package:picnic_app/core/domain/repositories/feature_flags_repository.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

/// fetches feature flags and saves them in global store for use across the entire app
class GetFeatureFlagsUseCase {
  const GetFeatureFlagsUseCase(
    this._featureFlagsRepository,
    this._featureFlagsStore,
  );

  final FeatureFlagsRepository _featureFlagsRepository;
  final FeatureFlagsStore _featureFlagsStore;

  Future<Either<GetFeatureFlagsFailure, Unit>> execute() async => _featureFlagsRepository
      .getFeatureFlags()
      .doOn(success: (flags) => _featureFlagsStore.featureFlags = flags)
      .mapSuccess((response) => unit);
}
