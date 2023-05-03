import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';
import 'package:picnic_app/core/environment_config/environment_config.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/features/debug/domain/model/change_environment_failure.dart';
import 'package:picnic_app/features/debug/domain/model/change_feature_flags_failure.dart';

abstract class EnvironmentConfigProvider {
  Future<bool> shouldUseShortLivedAuthTokens();

  Future<void> setShouldUseShortLivedAuthTokens({required bool shouldUse});

  /// returns config, should never throw and always return environment config, ideally if it could be cached internally
  /// for faster resolution
  Future<EnvironmentConfig> getConfig();

  Future<Either<ChangeEnvironmentFailure, Unit>> changeEnvironment(EnvironmentConfigSlug slug);

  /// list of headers to add to every GraphQL request
  Future<Map<String, String>> getAdditionalGraphQLHeaders();

  Future<Either<ChangeEnvironmentFailure, Unit>> updateAdditionalGraphQLHeaders(
    Map<String, String> additionalGraphqlHeaders,
  );

  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> getFeatureFlags();

  Future<Either<ChangeFeatureFlagsFailure, Unit>> changeFeatureFlags(FeatureFlags featureFlags);
}
