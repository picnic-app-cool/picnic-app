import 'package:mocktail/mocktail.dart';

import 'discover_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class DiscoverMocks {
  // MVP

  static late MockDiscoverSearchResultsPresenter discoverSearchResultsPresenter;
  static late MockDiscoverSearchResultsPresentationModel discoverSearchResultsPresentationModel;
  static late MockDiscoverSearchResultsInitialParams discoverSearchResultsInitialParams;
  static late MockDiscoverSearchResultsNavigator discoverSearchResultsNavigator;
  static late MockDiscoverExplorePresenter discoverExplorePresenter;
  static late MockDiscoverExplorePresentationModel discoverExplorePresentationModel;
  static late MockDiscoverExploreInitialParams discoverExploreInitialParams;
  static late MockDiscoverExploreNavigator discoverExploreNavigator;
  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockDiscoverFailure discoverFailure;
  static late MockDiscoverUseCase discoverUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockDiscoverRepository discoverRepository;
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
    discoverSearchResultsPresenter = MockDiscoverSearchResultsPresenter();
    discoverSearchResultsPresentationModel = MockDiscoverSearchResultsPresentationModel();
    discoverSearchResultsInitialParams = MockDiscoverSearchResultsInitialParams();
    discoverSearchResultsNavigator = MockDiscoverSearchResultsNavigator();
    discoverExplorePresenter = MockDiscoverExplorePresenter();
    discoverExplorePresentationModel = MockDiscoverExplorePresentationModel();
    discoverExploreInitialParams = MockDiscoverExploreInitialParams();
    discoverExploreNavigator = MockDiscoverExploreNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    discoverFailure = MockDiscoverFailure();
    discoverUseCase = MockDiscoverUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    discoverRepository = MockDiscoverRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockDiscoverSearchResultsPresenter());
    registerFallbackValue(MockDiscoverSearchResultsPresentationModel());
    registerFallbackValue(MockDiscoverSearchResultsInitialParams());
    registerFallbackValue(MockDiscoverSearchResultsNavigator());
    registerFallbackValue(MockDiscoverExplorePresenter());
    registerFallbackValue(MockDiscoverExplorePresentationModel());
    registerFallbackValue(MockDiscoverExploreInitialParams());
    registerFallbackValue(MockDiscoverExploreNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockDiscoverFailure());
    registerFallbackValue(MockDiscoverUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockDiscoverRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
