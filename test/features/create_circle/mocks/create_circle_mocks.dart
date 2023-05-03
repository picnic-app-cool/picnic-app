import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';

import 'create_circle_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class CreateCircleMocks {
  // MVP

  static late MockCreateCircleNavigator createCircleNavigator;
  static late MockCreateCirclePresentationModel createCirclePresentationModel;
  static late MockCreateCirclePresenter createCirclePresenter;
  static late MockCreateCircleInitialParams createCircleInitialParams;
  static late MockCircleCreationRulesNavigator circleCreationRulesNavigator;
  static late MockCircleCreationRulesPresentationModel circleCreationRulesPresentationModel;
  static late MockCircleCreationRulesPresenter circleCreationRulesPresenter;
  static late MockCircleCreationRulesInitialParams circleCreationRulesInitialParams;
  static late MockCircleCreationSuccessNavigator circleCreationSuccessNavigator;
  static late MockCircleCreationSuccessPresentationModel circleCreationSuccessPresentationModel;
  static late MockCircleCreationSuccessPresenter circleCreationSuccessPresenter;
  static late MockCircleCreationSuccessInitialParams circleCreationSuccessInitialParams;
  static late MockRuleSelectionNavigator ruleSelectionNavigator;
  static late MockRuleSelectionPresentationModel ruleSelectionPresentationModel;
  static late MockRuleSelectionPresenter ruleSelectionPresenter;
//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockCreateCircleFailure createCircleFailure;
  static late MockCreateCircleUseCase createCircleUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockCircleCreationRepository circleCreationRepository;
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
    createCircleNavigator = MockCreateCircleNavigator();
    createCirclePresentationModel = MockCreateCirclePresentationModel();
    createCirclePresenter = MockCreateCirclePresenter();
    createCircleInitialParams = MockCreateCircleInitialParams();
    circleCreationRulesNavigator = MockCircleCreationRulesNavigator();
    circleCreationRulesPresentationModel = MockCircleCreationRulesPresentationModel();
    circleCreationRulesPresenter = MockCircleCreationRulesPresenter();
    circleCreationRulesInitialParams = MockCircleCreationRulesInitialParams();
    circleCreationSuccessNavigator = MockCircleCreationSuccessNavigator();
    circleCreationSuccessPresentationModel = MockCircleCreationSuccessPresentationModel();
    circleCreationSuccessPresenter = MockCircleCreationSuccessPresenter();
    circleCreationSuccessInitialParams = MockCircleCreationSuccessInitialParams();
    ruleSelectionNavigator = MockRuleSelectionNavigator();
    ruleSelectionPresentationModel = MockRuleSelectionPresentationModel();
    ruleSelectionPresenter = MockRuleSelectionPresenter();
//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    createCircleFailure = MockCreateCircleFailure();
    createCircleUseCase = MockCreateCircleUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    circleCreationRepository = MockCircleCreationRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockCreateCircleNavigator());
    registerFallbackValue(MockCreateCirclePresentationModel());
    registerFallbackValue(MockCreateCirclePresenter());
    registerFallbackValue(MockCreateCircleInitialParams());
    registerFallbackValue(MockCircleCreationRulesNavigator());
    registerFallbackValue(MockCircleCreationRulesPresentationModel());
    registerFallbackValue(MockCircleCreationRulesPresenter());
    registerFallbackValue(MockCircleCreationRulesInitialParams());
    registerFallbackValue(MockCircleCreationSuccessNavigator());
    registerFallbackValue(MockCircleCreationSuccessPresentationModel());
    registerFallbackValue(MockCircleCreationSuccessPresenter());
    registerFallbackValue(MockCircleCreationSuccessInitialParams());
    registerFallbackValue(MockRuleSelectionNavigator());
    registerFallbackValue(MockRuleSelectionPresentationModel());
    registerFallbackValue(MockRuleSelectionPresenter());
//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockCreateCircleFailure());
    registerFallbackValue(MockCreateCircleUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockCircleCreationRepository());
    registerFallbackValue(const CircleInput.empty());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
