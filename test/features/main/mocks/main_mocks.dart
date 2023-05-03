import 'package:mocktail/mocktail.dart';

import 'main_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class MainMocks {
  // MVP

  static late MockMainPresenter mainPresenter;
  static late MockMainPresentationModel mainPresentationModel;
  static late MockMainInitialParams mainInitialParams;
  static late MockMainNavigator mainNavigator;

  static late MockLanguagesListPresenter languagesListPresenter;
  static late MockLanguagesListPresentationModel languagesListPresentationModel;
  static late MockLanguagesListInitialParams languagesListInitialParams;
  static late MockLanguagesListNavigator languagesListNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  //DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockLanguageRepository languageRepository;
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
    mainPresenter = MockMainPresenter();
    mainPresentationModel = MockMainPresentationModel();
    mainInitialParams = MockMainInitialParams();
    mainNavigator = MockMainNavigator();

    languagesListPresenter = MockLanguagesListPresenter();
    languagesListPresentationModel = MockLanguagesListPresentationModel();
    languagesListInitialParams = MockLanguagesListInitialParams();
    languagesListNavigator = MockLanguagesListNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    languageRepository = MockLanguageRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockMainPresenter());
    registerFallbackValue(MockMainPresentationModel());
    registerFallbackValue(MockMainInitialParams());
    registerFallbackValue(MockMainNavigator());

    registerFallbackValue(MockLanguagesListPresenter());
    registerFallbackValue(MockLanguagesListPresentationModel());
    registerFallbackValue(MockLanguagesListInitialParams());
    registerFallbackValue(MockLanguagesListNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockLanguageRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
