import 'package:mocktail/mocktail.dart';

import 'slices_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class SlicesMocks {
  // MVP

  static late MockEditSliceRulesPresenter editSliceRulesPresenter;
  static late MockEditSliceRulesPresentationModel editSliceRulesPresentationModel;
  static late MockEditSliceRulesInitialParams editSliceRulesInitialParams;
  static late MockEditSliceRulesNavigator editSliceRulesNavigator;
  static late MockJoinRequestsPresenter joinRequestsPresenter;
  static late MockJoinRequestsPresentationModel joinRequestsPresentationModel;
  static late MockJoinRequestsInitialParams joinRequestsInitialParams;
  static late MockJoinRequestsNavigator joinRequestsNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetSliceJoinRequestsFailure getSliceJoinRequestsFailure;
  static late MockGetSliceJoinRequestsUseCase getSliceJoinRequestsUseCase;

  static late MockApproveJoinRequestFailure approveJoinRequestFailure;
  static late MockApproveJoinRequestUseCase approveJoinRequestUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

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
    editSliceRulesPresenter = MockEditSliceRulesPresenter();
    editSliceRulesPresentationModel = MockEditSliceRulesPresentationModel();
    editSliceRulesInitialParams = MockEditSliceRulesInitialParams();
    editSliceRulesNavigator = MockEditSliceRulesNavigator();
    joinRequestsPresenter = MockJoinRequestsPresenter();
    joinRequestsPresentationModel = MockJoinRequestsPresentationModel();
    joinRequestsInitialParams = MockJoinRequestsInitialParams();
    joinRequestsNavigator = MockJoinRequestsNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getSliceJoinRequestsFailure = MockGetSliceJoinRequestsFailure();
    getSliceJoinRequestsUseCase = MockGetSliceJoinRequestsUseCase();

    approveJoinRequestFailure = MockApproveJoinRequestFailure();
    approveJoinRequestUseCase = MockApproveJoinRequestUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS
    approveJoinRequestFailure = MockApproveJoinRequestFailure();
    approveJoinRequestUseCase = MockApproveJoinRequestUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockJoinRequestsPresenter());
    registerFallbackValue(MockJoinRequestsPresentationModel());
    registerFallbackValue(MockJoinRequestsInitialParams());
    registerFallbackValue(MockJoinRequestsNavigator());
    registerFallbackValue(MockEditSliceRulesPresenter());
    registerFallbackValue(MockEditSliceRulesPresentationModel());
    registerFallbackValue(MockEditSliceRulesInitialParams());
    registerFallbackValue(MockEditSliceRulesNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetSliceJoinRequestsFailure());
    registerFallbackValue(MockGetSliceJoinRequestsUseCase());

    registerFallbackValue(MockApproveJoinRequestFailure());
    registerFallbackValue(MockApproveJoinRequestUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE
    registerFallbackValue(MockApproveJoinRequestFailure());
    registerFallbackValue(MockApproveJoinRequestUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
