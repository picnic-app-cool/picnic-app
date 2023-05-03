import 'package:mocktail/mocktail.dart';

import 'force_update_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class ForceUpdateMocks {
  // MVP

  static late MockForceUpdatePresenter forceUpdatePresenter;
  static late MockForceUpdatePresentationModel forceUpdatePresentationModel;
  static late MockForceUpdateInitialParams forceUpdateInitialParams;
  static late MockForceUpdateNavigator forceUpdateNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES
  static late MockFetchMinAppVersionUseCase getMinAppVersionUseCase;

  static late MockFetchAppVersionFailure getAppVersionFailure;

  static late MockShouldShowForceUpdateUseCase shouldShowForceUpdateUseCase;

  static late MockOpenStoreFailure openStoreFailure;
  static late MockOpenStoreUseCase openStoreUseCase;

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
    forceUpdatePresenter = MockForceUpdatePresenter();
    forceUpdatePresentationModel = MockForceUpdatePresentationModel();
    forceUpdateInitialParams = MockForceUpdateInitialParams();
    forceUpdateNavigator = MockForceUpdateNavigator();
    getMinAppVersionUseCase = MockFetchMinAppVersionUseCase();
    getMinAppVersionUseCase = MockFetchMinAppVersionUseCase();
    shouldShowForceUpdateUseCase = MockShouldShowForceUpdateUseCase();
    openStoreUseCase = MockOpenStoreUseCase();
    openStoreFailure = MockOpenStoreFailure();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockForceUpdatePresenter());
    registerFallbackValue(MockForceUpdatePresentationModel());
    registerFallbackValue(MockForceUpdateInitialParams());
    registerFallbackValue(MockForceUpdateNavigator());
    registerFallbackValue(MockFetchAppVersionFailure());
    registerFallbackValue(MockOpenStoreFailure());
    registerFallbackValue(MockOpenStoreUseCase());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
