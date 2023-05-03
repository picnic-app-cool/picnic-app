import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/domain/model/get_feature_flags_failure.dart';
import 'package:picnic_app/core/domain/model/secure_local_storage_key.dart';
import 'package:picnic_app/core/domain/repositories/secure_local_storage_repository.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/environment_config/environment_config.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/core/utils/task_queue.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/domain/model/change_environment_failure.dart';
import 'package:picnic_app/features/debug/domain/model/change_feature_flags_failure.dart';

class DebugEnvironmentConfigProvider implements EnvironmentConfigProvider {
  DebugEnvironmentConfigProvider(this._featureFlagsDefaults);

  final TaskQueue<EnvironmentConfig> _configTaskQueue = TaskQueue();
  final TaskQueue<Map<String, String>> _headersTaskQueue = TaskQueue();
  final TaskQueue<Either<GetFeatureFlagsFailure, FeatureFlags>> _featureFlagsTaskQueue = TaskQueue();
  final FeatureFlagsDefaults _featureFlagsDefaults;

  EnvironmentConfig? _config;
  Map<String, String>? _additionalHeaders;
  FeatureFlags? _featureFlags;

  // config provider is created even before dependencies are created, thus we cannot inject this in constructor,
  // but only rather on runtime. small hack, but life is much easier this way (this is only for debug code, release code
  // is done without any hacks like that in ProdEnvironmentConfigProvider!
  SecureLocalStorageRepository get _secureStorage => getIt<SecureLocalStorageRepository>();

  // config provider is created even before dependencies are created, thus we cannot inject this in constructor,
  // but only rather on runtime. small hack, but life is much easier this way (this is only for debug code, release code
  // is done without any hacks like that in ProdEnvironmentConfigProvider!
  UserPreferencesRepository get _prefsRepository => getIt<UserPreferencesRepository>();

  @override
  Future<EnvironmentConfig> getConfig() async {
    return _configTaskQueue.run(() async {
      return _config ??= await _getConfigFromSecureStorage();
    });
  }

  @override
  Future<Map<String, String>> getAdditionalGraphQLHeaders() async {
    return _headersTaskQueue.run(() async {
      return _additionalHeaders ??= await _getAdditionalGraphQLHeadersFromStorage();
    });
  }

  @override
  Future<Either<ChangeEnvironmentFailure, Unit>> changeEnvironment(EnvironmentConfigSlug slug) {
    return _secureStorage
        .write(
          key: SecureLocalStorageKey.environmentConfig,
          value: slug.value,
        )
        .doOn(success: (_) => _config = null)
        .mapFailure(ChangeEnvironmentFailure.unknown);
  }

  @override
  Future<Either<ChangeEnvironmentFailure, Unit>> updateAdditionalGraphQLHeaders(
    Map<String, String> additionalGraphqlHeaders,
  ) {
    return _secureStorage
        .write(
          key: SecureLocalStorageKey.additionalGraphQLHeaders,
          value: jsonEncode(additionalGraphqlHeaders),
        )
        .doOn(success: (_) => _additionalHeaders = null)
        .mapFailure(ChangeEnvironmentFailure.unknown);
  }

  @override
  Future<Either<ChangeFeatureFlagsFailure, Unit>> changeFeatureFlags(FeatureFlags featureFlags) {
    final jsonMap = featureFlags.flags.map((key, value) => MapEntry(key.name, value));
    return _secureStorage
        .write(
          key: SecureLocalStorageKey.featureFlags,
          value: jsonEncode(jsonMap),
        )
        .doOn(success: (_) => _featureFlags = null)
        .mapFailure(ChangeFeatureFlagsFailure.unknown);
  }

  @override
  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> getFeatureFlags() async {
    return _featureFlagsTaskQueue.run(() async {
      if (_featureFlags != null) {
        return success(_featureFlags!);
      }
      return _getFeatureFlagsFromStorage();
    });
  }

  @override
  Future<bool> shouldUseShortLivedAuthTokens() async {
    return _prefsRepository.shouldUseShortLivedAuthTokens().asyncFold(
          (fail) => false,
          (shouldUse) => shouldUse,
        );
  }

  @override
  Future<void> setShouldUseShortLivedAuthTokens({required bool shouldUse}) {
    return _prefsRepository.saveShouldUseShortLivedAuthTokens(shouldUse: shouldUse);
  }

  Future<Map<String, String>> _getAdditionalGraphQLHeadersFromStorage() async {
    return _secureStorage.read<String>(key: SecureLocalStorageKey.additionalGraphQLHeaders).asyncFold(
      (fail) {
        logError(fail);
        return {};
      },
      (headersString) {
        return _tryParseHeaders(headersString);
      },
    );
  }

  Map<String, String> _tryParseHeaders(String? headersString) {
    try {
      final headers = jsonDecode(headersString ?? '{}');
      if (headers is Map) {
        return headers.map<String, String>((key, value) => MapEntry(key.toString(), value.toString()));
      }
      return {};
    } catch (ex) {
      debugLog("json is invalid while decoding debug headers: '$headersString'", this);
      return {};
    }
  }

  Future<EnvironmentConfig> _getConfigFromSecureStorage() async {
    _config = await _secureStorage
        .read<String>(key: SecureLocalStorageKey.environmentConfig) //
        .asyncFold(
      (fail) {
        logError(fail);
        return null;
      },
      (slug) {
        return EnvironmentConfig.fromString(slug);
      },
    );
    return _config ?? const EnvironmentConfig.staging();
  }

  Future<Either<GetFeatureFlagsFailure, FeatureFlags>> _getFeatureFlagsFromStorage() async {
    return _secureStorage
        .read<String>(key: SecureLocalStorageKey.featureFlags) //
        .asyncFold(
      (fail) {
        logError(fail);
        return failure(const GetFeatureFlagsFailure.unknown('Unable to parse feature flags'));
      },
      (mapString) {
        return _tryParseFeatureFlags(mapString);
      },
    );
  }

  Either<GetFeatureFlagsFailure, FeatureFlags> _tryParseFeatureFlags(String? featureFlags) {
    try {
      final flags = jsonDecode(featureFlags ?? '{}');
      if (flags is Map) {
        return success(
          FeatureFlags(
            flags: flags.map<FeatureFlagType, bool>(
              (key, value) => MapEntry(
                FeatureFlagType.values.firstWhere((element) => element.name == key),
                value == true,
              ),
            ),
            featureFlagsDefauls: _featureFlagsDefaults,
          ),
        );
      }
      return success(FeatureFlags.defaultFlags(_featureFlagsDefaults));
    } catch (ex, stack) {
      logError(
        ex,
        stack: stack,
        reason: "json is invalid: '$featureFlags'",
      );
      return failure(const GetFeatureFlagsFailure.unknown('Unable to parse feature flags'));
    }
  }
}
