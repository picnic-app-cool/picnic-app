import 'package:mocktail/mocktail.dart';

import 'in_app_notifications_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class InAppNotificationsMocks {
  // MVP

  static late MockNotificationsPresenter inAppNotificationsPresenter;
  static late MockNotificationsNavigator inAppNotificationsNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetInAppNotificationsUseCase getInAppNotificationsUseCase;

  static late MockAddInAppNotificationsFilterUseCase addInAppNotificationsFilterUseCase;

  static late MockRemoveInAppNotificationsFilterUseCase removeInAppNotificationsFilterUseCase;

  static late MockToggleInAppNotificationsUseCase toggleInAppNotificationsUseCase;

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
    inAppNotificationsPresenter = MockNotificationsPresenter();
    inAppNotificationsNavigator = MockNotificationsNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getInAppNotificationsUseCase = MockGetInAppNotificationsUseCase();

    addInAppNotificationsFilterUseCase = MockAddInAppNotificationsFilterUseCase();

    removeInAppNotificationsFilterUseCase = MockRemoveInAppNotificationsFilterUseCase();

    toggleInAppNotificationsUseCase = MockToggleInAppNotificationsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockNotificationsPresenter());
    registerFallbackValue(MockNotificationsNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetInAppNotificationsUseCase());

    registerFallbackValue(MockAddInAppNotificationsFilterUseCase());

    registerFallbackValue(MockRemoveInAppNotificationsFilterUseCase());

    registerFallbackValue(MockToggleInAppNotificationsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
