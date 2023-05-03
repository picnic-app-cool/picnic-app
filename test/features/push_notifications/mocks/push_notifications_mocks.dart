import 'package:mocktail/mocktail.dart';

import 'push_notifications_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class PushNotificationsMocks {
  // MVP

  static late MockSendPushNotificationPresenter sendPushNotificationPresenter;
  static late MockSendPushNotificationPresentationModel sendPushNotificationPresentationModel;
  static late MockSendPushNotificationInitialParams sendPushNotificationInitialParams;
  static late MockSendPushNotificationNavigator sendPushNotificationNavigator;

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockUpdateDeviceTokenFailure updateDeviceTokenFailure;
  static late MockUpdateDeviceTokenUseCase updateDeviceTokenUseCase;

  static late MockListenDeviceTokenUpdatesUseCase listenDeviceTokenUpdatesUseCase;

  static late MockGetPushNotificationsUseCase getPushNotificationsUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockPushNotificationRepository pushNotificationRepository;
  static late MockFirebaseMessagingWrapper firebaseMessagingWrapper;

//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD
  static late MockDeviceTokenUpdatesListenerContainer deviceTokenUpdatesListenerContainer;

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    sendPushNotificationPresenter = MockSendPushNotificationPresenter();
    sendPushNotificationPresentationModel = MockSendPushNotificationPresentationModel();
    sendPushNotificationInitialParams = MockSendPushNotificationInitialParams();
    sendPushNotificationNavigator = MockSendPushNotificationNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    updateDeviceTokenFailure = MockUpdateDeviceTokenFailure();
    updateDeviceTokenUseCase = MockUpdateDeviceTokenUseCase();

    listenDeviceTokenUpdatesUseCase = MockListenDeviceTokenUpdatesUseCase();

    getPushNotificationsUseCase = MockGetPushNotificationsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    pushNotificationRepository = MockPushNotificationRepository();
    firebaseMessagingWrapper = MockFirebaseMessagingWrapper();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
    deviceTokenUpdatesListenerContainer = MockDeviceTokenUpdatesListenerContainer();
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockSendPushNotificationPresenter());
    registerFallbackValue(MockSendPushNotificationPresentationModel());
    registerFallbackValue(MockSendPushNotificationInitialParams());
    registerFallbackValue(MockSendPushNotificationNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockUpdateDeviceTokenFailure());
    registerFallbackValue(MockUpdateDeviceTokenUseCase());

    registerFallbackValue(MockListenDeviceTokenUpdatesUseCase());

    registerFallbackValue(MockGetPushNotificationsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockPushNotificationRepository());
    registerFallbackValue(MockFirebaseMessagingWrapper());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
    registerFallbackValue(MockDeviceTokenUpdatesListenerContainer());
  }
}
