import 'package:mocktail/mocktail.dart';

import 'debug_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class DebugMocks {
  // MVP

  static late MockFeatureFlagsPresenter featureFlagsPresenter;
  static late MockFeatureFlagsPresentationModel featureFlagsPresentationModel;
  static late MockFeatureFlagsInitialParams featureFlagsInitialParams;
  static late MockFeatureFlagsNavigator featureFlagsNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockInvalidateTokenFailure invalidateTokenFailure;
  static late MockInvalidateTokenUseCase invalidateTokenUseCase;

  static late MockRestartAppFailure restartAppFailure;
  static late MockRestartAppUseCase restartAppUseCase;

  static late MockChangeEnvironmentFailure changeEnvironmentFailure;
  static late MockChangeEnvironmentUseCase changeEnvironmentUseCase;

  static late MockChangeFeatureFlagsFailure changeFeatureFlagsFailure;
  static late MockChangeFeatureFlagsUseCase changeFeatureFlagsUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    featureFlagsPresenter = MockFeatureFlagsPresenter();
    featureFlagsPresentationModel = MockFeatureFlagsPresentationModel();
    featureFlagsInitialParams = MockFeatureFlagsInitialParams();
    featureFlagsNavigator = MockFeatureFlagsNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    invalidateTokenFailure = MockInvalidateTokenFailure();
    invalidateTokenUseCase = MockInvalidateTokenUseCase();

    restartAppFailure = MockRestartAppFailure();
    restartAppUseCase = MockRestartAppUseCase();

    changeEnvironmentFailure = MockChangeEnvironmentFailure();
    changeEnvironmentUseCase = MockChangeEnvironmentUseCase();

    changeFeatureFlagsFailure = MockChangeFeatureFlagsFailure();
    changeFeatureFlagsUseCase = MockChangeFeatureFlagsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockFeatureFlagsPresenter());
    registerFallbackValue(MockFeatureFlagsPresentationModel());
    registerFallbackValue(MockFeatureFlagsInitialParams());
    registerFallbackValue(MockFeatureFlagsNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockInvalidateTokenFailure());
    registerFallbackValue(MockInvalidateTokenUseCase());

    registerFallbackValue(MockRestartAppFailure());
    registerFallbackValue(MockRestartAppUseCase());

    registerFallbackValue(MockChangeEnvironmentFailure());
    registerFallbackValue(MockChangeEnvironmentUseCase());

    registerFallbackValue(MockChangeFeatureFlagsFailure());
    registerFallbackValue(MockChangeFeatureFlagsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
