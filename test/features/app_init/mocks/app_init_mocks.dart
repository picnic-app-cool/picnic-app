import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_initial_params.dart';

import 'app_init_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class AppInitMocks {
  // MVP

  static late MockAppInitPresenter appInitPresenter;
  static late MockAppInitPresentationModel appInitPresentationModel;
  static late MockAppInitInitialParams appInitInitialParams;
  static late MockAppInitNavigator appInitNavigator;

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES
  static late MockAppInitFailure appInitFailure;
  static late MockAppInitUseCase appInitUseCase;

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
    appInitPresenter = MockAppInitPresenter();
    appInitPresentationModel = MockAppInitPresentationModel();
    appInitInitialParams = MockAppInitInitialParams();
    appInitNavigator = MockAppInitNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    appInitFailure = MockAppInitFailure();
    appInitUseCase = MockAppInitUseCase();
    //DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockAppInitPresenter());
    registerFallbackValue(MockAppInitPresentationModel());
    registerFallbackValue(MockAppInitInitialParams());
    registerFallbackValue(MockAppInitNavigator());
    registerFallbackValue(const FeaturesIndexInitialParams()); // TODO remove it when featuresIndexPage is removed
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockAppInitFailure());
    registerFallbackValue(MockAppInitUseCase());
    //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
