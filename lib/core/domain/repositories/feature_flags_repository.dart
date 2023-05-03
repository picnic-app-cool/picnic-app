import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';

abstract class FeatureFlagsRepository {
  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> getFeatureFlags();
}
