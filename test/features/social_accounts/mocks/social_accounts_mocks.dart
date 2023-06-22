import 'package:mocktail/mocktail.dart';

import 'social_accounts_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class SocialAccountsMocks {
  // MVP

  static late MockConnectAccountsPresenter connectAccountsPresenter;
  static late MockConnectAccountsPresentationModel connectAccountsPresentationModel;
  static late MockConnectAccountsInitialParams connectAccountsInitialParams;
  static late MockConnectAccountsNavigator connectAccountsNavigator;

  static late MockConnectAccountsBottomSheetPresenter connectAccountsBottomSheetPresenter;
  static late MockConnectAccountsBottomSheetPresentationModel connectAccountsBottomSheetPresentationModel;
  static late MockConnectAccountsBottomSheetInitialParams connectAccountsBottomSheetInitialParams;
  static late MockConnectAccountsBottomSheetNavigator connectAccountsBottomSheetNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetConnectedSocialAccountsFailure getConnectedSocialAccountsFailure;
  static late MockGetConnectedSocialAccountsUseCase getConnectedSocialAccountsUseCase;

  static late MockLinkDiscordAccountFailure linkDiscordAccountFailure;
  static late MockLinkDiscordAccountUseCase linkDiscordAccountUseCase;

  static late MockLinkRobloxAccountFailure linkRobloxAccountFailure;
  static late MockLinkRobloxAccountUseCase linkRobloxAccountUseCase;

  static late MockUnlinkRobloxAccountFailure unlinkRobloxAccountFailure;
  static late MockUnlinkRobloxAccountUseCase unlinkRobloxAccountUseCase;

  static late MockUnlinkDiscordAccountFailure unlinkDiscordAccountFailure;
  static late MockUnlinkDiscordAccountUseCase unlinkDiscordAccountUseCase;

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
    connectAccountsPresenter = MockConnectAccountsPresenter();
    connectAccountsPresentationModel = MockConnectAccountsPresentationModel();
    connectAccountsInitialParams = MockConnectAccountsInitialParams();
    connectAccountsNavigator = MockConnectAccountsNavigator();

    connectAccountsBottomSheetPresenter = MockConnectAccountsBottomSheetPresenter();
    connectAccountsBottomSheetPresentationModel = MockConnectAccountsBottomSheetPresentationModel();
    connectAccountsBottomSheetInitialParams = MockConnectAccountsBottomSheetInitialParams();
    connectAccountsBottomSheetNavigator = MockConnectAccountsBottomSheetNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getConnectedSocialAccountsFailure = MockGetConnectedSocialAccountsFailure();
    getConnectedSocialAccountsUseCase = MockGetConnectedSocialAccountsUseCase();

    linkDiscordAccountFailure = MockLinkDiscordAccountFailure();
    linkDiscordAccountUseCase = MockLinkDiscordAccountUseCase();

    linkRobloxAccountFailure = MockLinkRobloxAccountFailure();
    linkRobloxAccountUseCase = MockLinkRobloxAccountUseCase();

    unlinkRobloxAccountFailure = MockUnlinkRobloxAccountFailure();
    unlinkRobloxAccountUseCase = MockUnlinkRobloxAccountUseCase();

    unlinkDiscordAccountFailure = MockUnlinkDiscordAccountFailure();
    unlinkDiscordAccountUseCase = MockUnlinkDiscordAccountUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockConnectAccountsPresenter());
    registerFallbackValue(MockConnectAccountsPresentationModel());
    registerFallbackValue(MockConnectAccountsInitialParams());
    registerFallbackValue(MockConnectAccountsNavigator());

    registerFallbackValue(MockConnectAccountsBottomSheetPresenter());
    registerFallbackValue(MockConnectAccountsBottomSheetPresentationModel());
    registerFallbackValue(MockConnectAccountsBottomSheetInitialParams());
    registerFallbackValue(MockConnectAccountsBottomSheetNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetConnectedSocialAccountsFailure());
    registerFallbackValue(MockGetConnectedSocialAccountsUseCase());

    registerFallbackValue(MockLinkDiscordAccountFailure());
    registerFallbackValue(MockLinkDiscordAccountUseCase());

    registerFallbackValue(MockLinkRobloxAccountFailure());
    registerFallbackValue(MockLinkRobloxAccountUseCase());

    registerFallbackValue(MockUnlinkRobloxAccountFailure());
    registerFallbackValue(MockUnlinkRobloxAccountUseCase());

    registerFallbackValue(MockUnlinkDiscordAccountFailure());
    registerFallbackValue(MockUnlinkDiscordAccountUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
