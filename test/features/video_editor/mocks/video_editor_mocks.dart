import 'package:mocktail/mocktail.dart';

import 'video_editor_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class VideoEditorMocks {
  // MVP

  static late MockVideoEditorPresenter videoEditorPresenter;
  static late MockVideoEditorPresentationModel videoEditorPresentationModel;
  static late MockVideoEditorInitialParams videoEditorInitialParams;
  static late MockVideoEditorNavigator videoEditorNavigator;
  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

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
    videoEditorPresenter = MockVideoEditorPresenter();
    videoEditorPresentationModel = MockVideoEditorPresentationModel();
    videoEditorInitialParams = MockVideoEditorInitialParams();
    videoEditorNavigator = MockVideoEditorNavigator();
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
    registerFallbackValue(MockVideoEditorPresenter());
    registerFallbackValue(MockVideoEditorPresentationModel());
    registerFallbackValue(MockVideoEditorInitialParams());
    registerFallbackValue(MockVideoEditorNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
