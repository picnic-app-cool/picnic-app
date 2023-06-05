import 'package:mocktail/mocktail.dart';

import 'pods_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class PodsMocks {
  // MVP

  static late MockPodsCategoriesPresenter podsCategoriesPresenter;
  static late MockPodsCategoriesPresentationModel podsCategoriesPresentationModel;
  static late MockPodsCategoriesInitialParams podsCategoriesInitialParams;
  static late MockPodsCategoriesNavigator podsCategoriesNavigator;

  static late MockPodBottomSheetPresenter podBottomSheetPresenter;
  static late MockPodBottomSheetPresentationModel podBottomSheetPresentationModel;
  static late MockPodBottomSheetInitialParams podBottomSheetInitialParams;
  static late MockPodBottomSheetNavigator podBottomSheetNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetPodsTagsFailure getPodsTagsFailure;
  static late MockGetPodsTagsUseCase getPodsTagsUseCase;

  static late MockSavePodFailure savePodFailure;
  static late MockSavePodUseCase savePodUseCase;

  static late MockGetSavedPodsFailure getSavedPodsFailure;
  static late MockGetSavedPodsUseCase getSavedPodsUseCase;

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
    podsCategoriesPresenter = MockPodsCategoriesPresenter();
    podsCategoriesPresentationModel = MockPodsCategoriesPresentationModel();
    podsCategoriesInitialParams = MockPodsCategoriesInitialParams();
    podsCategoriesNavigator = MockPodsCategoriesNavigator();

    podBottomSheetPresenter = MockPodBottomSheetPresenter();
    podBottomSheetPresentationModel = MockPodBottomSheetPresentationModel();
    podBottomSheetInitialParams = MockPodBottomSheetInitialParams();
    podBottomSheetNavigator = MockPodBottomSheetNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getPodsTagsFailure = MockGetPodsTagsFailure();
    getPodsTagsUseCase = MockGetPodsTagsUseCase();

    savePodFailure = MockSavePodFailure();
    savePodUseCase = MockSavePodUseCase();

    getSavedPodsFailure = MockGetSavedPodsFailure();
    getSavedPodsUseCase = MockGetSavedPodsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockPodsCategoriesPresenter());
    registerFallbackValue(MockPodsCategoriesPresentationModel());
    registerFallbackValue(MockPodsCategoriesInitialParams());
    registerFallbackValue(MockPodsCategoriesNavigator());

    registerFallbackValue(MockPodBottomSheetPresenter());
    registerFallbackValue(MockPodBottomSheetPresentationModel());
    registerFallbackValue(MockPodBottomSheetInitialParams());
    registerFallbackValue(MockPodBottomSheetNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetPodsTagsFailure());
    registerFallbackValue(MockGetPodsTagsUseCase());

    registerFallbackValue(MockSavePodFailure());
    registerFallbackValue(MockSavePodUseCase());

    registerFallbackValue(MockGetSavedPodsFailure());
    registerFallbackValue(MockGetSavedPodsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
