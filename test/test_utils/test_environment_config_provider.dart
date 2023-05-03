import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';
import 'package:picnic_app/core/environment_config/environment_config.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/features/debug/domain/model/change_environment_failure.dart';
import 'package:picnic_app/features/debug/domain/model/change_feature_flags_failure.dart';

import 'test_utils.dart';

class TestEnvironmentConfigProvider extends EnvironmentConfigProvider {
  TestEnvironmentConfigProvider(this._featureFlagsDefaults);

  final FeatureFlagsDefaults _featureFlagsDefaults;

  @override
  Future<EnvironmentConfig> getConfig() async => const EnvironmentConfig(
        slug: EnvironmentConfigSlug.production,
        baseChatUri: 'wss://non.existing.address/connection/websocket',
        baseInAppNotificationsUri: 'wss://non.existing.address/connection/websocket',
        baseGraphQLUrl: 'https://non.existing.address',
      );

  @override
  Future<Either<ChangeEnvironmentFailure, Unit>> changeEnvironment(EnvironmentConfigSlug slug) {
    throw UnimplementedError("not possible to change environments in tests");
  }

  @override
  Future<Map<String, String>> getAdditionalGraphQLHeaders() async {
    return {};
  }

  @override
  Future<Either<ChangeEnvironmentFailure, Unit>> updateAdditionalGraphQLHeaders(
    Map<String, String> additionalGraphqlHeaders,
  ) {
    throw UnimplementedError("not possible to change graphql headers in tests");
  }

  @override
  Future<Either<ChangeFeatureFlagsFailure, Unit>> changeFeatureFlags(FeatureFlags featureFlags) {
    throw UnimplementedError("not possible to change feature flags in tests");
  }

  @override
  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> getFeatureFlags() {
    return successFuture(FeatureFlags.defaultFlags(_featureFlagsDefaults));
  }

  @override
  Future<bool> shouldUseShortLivedAuthTokens() async {
    return true;
  }

  @override
  Future<void> setShouldUseShortLivedAuthTokens({required bool shouldUse}) {
    throw UnimplementedError("not possible to change 'should use short lived auth tokens' in tests");
  }
}
