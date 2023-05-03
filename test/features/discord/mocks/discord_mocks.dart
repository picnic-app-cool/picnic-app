import 'package:mocktail/mocktail.dart';

import 'discord_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class DiscordMocks {
  // MVP

  static late MockLinkDiscordPresenter linkDiscordPresenter;
  static late MockLinkDiscordPresentationModel linkDiscordPresentationModel;
  static late MockLinkDiscordInitialParams linkDiscordInitialParams;
  static late MockLinkDiscordNavigator linkDiscordNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockConnectDiscordServerFailure connectDiscordServerFailure;
  static late MockConnectDiscordServerUseCase connectDiscordServerUseCase;

  static late MockGetDiscordConfigFailure getDiscordServerFailure;
  static late MockGetDiscordConfigUseCase getDiscordConfigUseCase;

  static late MockRevokeDiscordWebhookFailure revokeDiscordWebhookFailure;
  static late MockRevokeDiscordWebhookUseCase revokeDiscordWebhookUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockDiscordRepository discordRepository;
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
    linkDiscordPresenter = MockLinkDiscordPresenter();
    linkDiscordPresentationModel = MockLinkDiscordPresentationModel();
    linkDiscordInitialParams = MockLinkDiscordInitialParams();
    linkDiscordNavigator = MockLinkDiscordNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    connectDiscordServerFailure = MockConnectDiscordServerFailure();
    connectDiscordServerUseCase = MockConnectDiscordServerUseCase();

    getDiscordServerFailure = MockGetDiscordConfigFailure();
    getDiscordConfigUseCase = MockGetDiscordConfigUseCase();

    revokeDiscordWebhookFailure = MockRevokeDiscordWebhookFailure();
    revokeDiscordWebhookUseCase = MockRevokeDiscordWebhookUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    discordRepository = MockDiscordRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockLinkDiscordPresenter());
    registerFallbackValue(MockLinkDiscordPresentationModel());
    registerFallbackValue(MockLinkDiscordInitialParams());
    registerFallbackValue(MockLinkDiscordNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockConnectDiscordServerFailure());
    registerFallbackValue(MockConnectDiscordServerUseCase());

    registerFallbackValue(MockGetDiscordConfigFailure());
    registerFallbackValue(MockGetDiscordConfigUseCase());

    registerFallbackValue(MockRevokeDiscordWebhookFailure());
    registerFallbackValue(MockRevokeDiscordWebhookUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockDiscordRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
