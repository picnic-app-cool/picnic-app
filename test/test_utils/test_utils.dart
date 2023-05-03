import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/hive/hive_path_provider.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/analytics_observer.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/picnic_app_init_params.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../mocks/mocks.dart';
import 'test_environment_config_provider.dart';

Future<Either<F, S>> successFuture<F, S>(S result) => Future.value(success(result));

Stream<CacheableResult<F, S>> successCacheableResult<F, S>(S result, {CacheableSource? source}) => Stream.value(
      CacheableResult(
        result: success(result),
        source: source,
      ),
    );

//ignore: unused-code
Stream<CacheableResult<F, S>> failureCacheableResult<F, S>(F fail, {CacheableSource? source}) => Stream.value(
      CacheableResult(
        result: failure(fail),
        source: source,
      ),
    );

Future<Either<F, S>> failFuture<F, S>(F fail) => Future.value(failure(fail));

Future<void> prepareAppForUnitTests() async {
  KeyboardVisibilityTesting.setVisibilityForTesting(false);
  isUnitTests = true;
  resetMocktailState();
  Mocks.init();
  notImplemented = ({message, context}) => doNothing();
  overrideAppLocalizations(AppLocalizationsEn());
  // Without this line we'll get `A Timer is still pending even after the widget tree was disposed.`
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  await configureDependenciesForTests();
}

Future<void> configureDependenciesForTests() async {
  await getIt.reset();
  getIt.allowReassignment = true;
  const featureFlagsDefaults = FeatureFlagsDefaults();
  final picnicAppInitParams = PicnicAppInitParams(
    showDebugScreen: false,
    featureFlagsDefaults: featureFlagsDefaults,
    environmentConfigProvider: TestEnvironmentConfigProvider(featureFlagsDefaults),
    devicePlatformProvider: Mocks.devicePlatformProvider,
  );
  configureDependencies(picnicAppInitParams);
  getIt.registerFactory<FirebaseAuth>(() => Mocks.firebaseAuth);
  getIt.registerFactory<AnalyticsObserver>(() => Mocks.analyticsObserver);
  getIt.registerFactory<CurrentTimeProvider>(() => Mocks.currentTimeProvider);
  getIt.registerFactory<HivePathProvider>(() => TextHivePathProvider());
  when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 10, 12, 17, 53, 49));
}

Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  overrideAppLocalizations(AppLocalizationsEn());
  await loadAppFonts();
  await prepareAppForUnitTests();
  // ignore: do_not_use_environment
  const isCi = bool.fromEnvironment('isCI');

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        // ignore: avoid_redundant_argument_values
        enabled: !isCi,
      ),
    ),
    run: () async {
      return testMain();
    },
  );
}

@isTest
void gqlQueryTest(String name, {required String query}) {
  test('$name is valid GraphQL query', () {
    final doc = gql(query);
    expect(doc, isNotNull);
  });
}

/// helper method to re-register given dependency in tests
void reRegister<T extends Object>(T obj) {
  getIt.registerFactory<T>(() => obj);
}

extension MocktailWhenEither<T, L, R> on When<Future<Either<L, R>>> {
  void thenSuccess(R Function(Invocation) success) => thenAnswer((invocation) => successFuture(success(invocation)));

  void thenFailure(L Function(Invocation) failure) => thenAnswer((invocation) => failFuture(failure(invocation)));
}

extension FeatureFlagsTestExt on FeatureFlags {
  FeatureFlags enable(FeatureFlagType flag) {
    final localFlags = Map<FeatureFlagType, bool>.from(flags);
    localFlags[flag] = true;
    return copyWith(flags: localFlags);
  }

  FeatureFlags disable(FeatureFlagType flag) {
    final localFlags = Map<FeatureFlagType, bool>.from(flags);
    localFlags[flag] = false;
    return copyWith(flags: localFlags);
  }
}

class TextHivePathProvider implements HivePathProvider {
  @override
  Future<String> get path async => ".";
}
