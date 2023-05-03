import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';
import 'package:picnic_app/core/environment_config/environment_config.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/debug/domain/model/change_environment_failure.dart';
import 'package:picnic_app/features/debug/domain/model/change_feature_flags_failure.dart';

class ProdEnvironmentConfigProvider implements EnvironmentConfigProvider {
  ProdEnvironmentConfigProvider(this._featureFlagsDefaults);

  final FeatureFlagsDefaults _featureFlagsDefaults;

  @override
  Future<EnvironmentConfig> getConfig() async {
    return const EnvironmentConfig.prod();
  }

  @override
  Future<Either<ChangeEnvironmentFailure, Unit>> changeEnvironment(EnvironmentConfigSlug slug) async {
    return failure(
      const ChangeEnvironmentFailure.unknown("its not possible to change environment in prod builds"),
    );
  }

  @override
  Future<Map<String, String>> getAdditionalGraphQLHeaders() async {
    return {};
  }

  @override
  Future<Either<ChangeEnvironmentFailure, Unit>> updateAdditionalGraphQLHeaders(
    Map<String, String> additionalGraphqlHeaders,
  ) async {
    return failure(
      const ChangeEnvironmentFailure.unknown("its not possible to add headers in prod builds"),
    );
  }

  @override
  Future<Either<ChangeFeatureFlagsFailure, Unit>> changeFeatureFlags(FeatureFlags featureFlags) async {
    return failure(
      const ChangeFeatureFlagsFailure.unknown("its not possible to change feature flags in prod builds"),
    );
  }

  @override
  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> getFeatureFlags() async {
    return success(FeatureFlags.defaultFlags(_featureFlagsDefaults));
  }

  @override
  Future<bool> shouldUseShortLivedAuthTokens() async {
    // in prod builds, we don't use short-lived tokens, never.
    return false;
  }

  @override
  Future<void> setShouldUseShortLivedAuthTokens({required bool shouldUse}) async {
    // in prod builds, we don't use short-lived tokens, never.
    doNothing();
  }
}
