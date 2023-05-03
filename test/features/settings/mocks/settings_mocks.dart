import 'package:mocktail/mocktail.dart';

import 'settings_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class SettingsMocks {
  // MVP

  static late MockSettingsHomePresenter settingsHomePresenter;
  static late MockSettingsHomePresentationModel settingsHomePresentationModel;
  static late MockSettingsHomeInitialParams settingsHomeInitialParams;
  static late MockSettingsHomeNavigator settingsHomeNavigator;
  static late MockLanguagePresenter languagePresenter;
  static late MockLanguagePresentationModel languagePresentationModel;
  static late MockLanguageInitialParams languageInitialParams;
  static late MockLanguageNavigator languageNavigator;
  static late MockBlockedListPresenter blockedListPresenter;
  static late MockBlockedListPresentationModel blockedListPresentationModel;
  static late MockBlockedListInitialParams blockedListInitialParams;
  static late MockBlockedListNavigator blockedListNavigator;
  static late MockCommunityGuidelinesPresenter communityGuidelinesPresenter;
  static late MockCommunityGuidelinesPresentationModel communityGuidelinesPresentationModel;
  static late MockCommunityGuidelinesInitialParams communityGuidelinesInitialParams;
  static late MockCommunityGuidelinesNavigator communityGuidelinesNavigator;
  static late MockGetVerifiedPresenter getVerifiedPresenter;
  static late MockGetVerifiedPresentationModel getVerifiedPresentationModel;
  static late MockGetVerifiedInitialParams getVerifiedInitialParams;
  static late MockGetVerifiedNavigator getVerifiedNavigator;
  static late MockNotificationSettingsPresenter notificationSettingsPresenter;
  static late MockNotificationSettingsPresentationModel notificationSettingsPresentationModel;
  static late MockNotificationSettingsInitialParams notificationSettingsInitialParams;
  static late MockNotificationSettingsNavigator notificationSettingsNavigator;
  static late MockPrivacySettingsPresenter privacySettingsPresenter;
  static late MockPrivacySettingsPresentationModel privacySettingsPresentationModel;
  static late MockPrivacySettingsInitialParams privacySettingsInitialParams;
  static late MockPrivacySettingsNavigator privacySettingsNavigator;
  static late MockDeleteAccountPresenter deleteAccountPresenter;
  static late MockDeleteAccountPresentationModel deleteAccountPresentationModel;
  static late MockDeleteAccountInitialParams deleteAccountInitialParams;
  static late MockDeleteAccountNavigator deleteAccountNavigator;

  static late MockDeleteAccountReasonsPresenter deleteAccountReasonsPresenter;
  static late MockDeleteAccountReasonsPresentationModel deleteAccountReasonsPresentationModel;
  static late MockDeleteAccountReasonsInitialParams deleteAccountReasonsInitialParams;
  static late MockDeleteAccountReasonsNavigator deleteAccountReasonsNavigator;

  static late MockInviteFriendsPresenter inviteFriendsPresenter;
  static late MockInviteFriendsPresentationModel inviteFriendsPresentationModel;
  static late MockInviteFriendsInitialParams inviteFriendsInitialParams;
  static late MockInviteFriendsNavigator inviteFriendsNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetNotificationSettingsFailure getNotificationSettingsFailure;
  static late MockGetNotificationSettingsUseCase getNotificationSettingsUseCase;
  static late MockGetBlockListFailure getBlockListFailure;
  static late MockGetBlockListUseCase getBlockListUseCase;

  static late MockRequestDeleteAccountFailure requestDeleteAccountFailure;
  static late MockRequestDeleteAccountUseCase requestDeleteAccountUseCase;

  static late MockUpdatePrivacySettingsFailure updatePrivacySettingsFailure;
  static late MockUpdatePrivacySettingsUseCase updatePrivacySettingsUseCase;

  static late MockGetPrivacySettingsFailure getPrivacySettingsFailure;
  static late MockGetPrivacySettingsUseCase getPrivacySettingsUseCase;

  static late MockUpdateNotificationSettingsFailure updateNotificationSettingsFailure;
  static late MockUpdateNotificationSettingsUseCase updateNotificationSettingsUseCase;

  static late MockGetDeleteAccountReasonsFailure getDeleteAccountReasonsFailure;
  static late MockGetDeleteAccountReasonsUseCase getDeleteAccountReasonsUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockDocumentsRepository documentsRepository;
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
    settingsHomePresenter = MockSettingsHomePresenter();
    settingsHomePresentationModel = MockSettingsHomePresentationModel();
    settingsHomeInitialParams = MockSettingsHomeInitialParams();
    settingsHomeNavigator = MockSettingsHomeNavigator();
    languagePresenter = MockLanguagePresenter();
    languagePresentationModel = MockLanguagePresentationModel();
    languageInitialParams = MockLanguageInitialParams();
    languageNavigator = MockLanguageNavigator();
    blockedListPresenter = MockBlockedListPresenter();
    blockedListPresentationModel = MockBlockedListPresentationModel();
    blockedListInitialParams = MockBlockedListInitialParams();
    blockedListNavigator = MockBlockedListNavigator();
    communityGuidelinesPresenter = MockCommunityGuidelinesPresenter();
    communityGuidelinesPresentationModel = MockCommunityGuidelinesPresentationModel();
    communityGuidelinesInitialParams = MockCommunityGuidelinesInitialParams();
    communityGuidelinesNavigator = MockCommunityGuidelinesNavigator();
    getVerifiedPresenter = MockGetVerifiedPresenter();
    getVerifiedPresentationModel = MockGetVerifiedPresentationModel();
    getVerifiedInitialParams = MockGetVerifiedInitialParams();
    getVerifiedNavigator = MockGetVerifiedNavigator();
    notificationSettingsPresenter = MockNotificationSettingsPresenter();
    notificationSettingsPresentationModel = MockNotificationSettingsPresentationModel();
    notificationSettingsInitialParams = MockNotificationSettingsInitialParams();
    notificationSettingsNavigator = MockNotificationSettingsNavigator();
    privacySettingsPresenter = MockPrivacySettingsPresenter();
    privacySettingsPresentationModel = MockPrivacySettingsPresentationModel();
    privacySettingsInitialParams = MockPrivacySettingsInitialParams();
    privacySettingsNavigator = MockPrivacySettingsNavigator();
    deleteAccountPresenter = MockDeleteAccountPresenter();
    deleteAccountPresentationModel = MockDeleteAccountPresentationModel();
    deleteAccountInitialParams = MockDeleteAccountInitialParams();
    deleteAccountNavigator = MockDeleteAccountNavigator();
    deleteAccountReasonsPresenter = MockDeleteAccountReasonsPresenter();
    deleteAccountReasonsPresentationModel = MockDeleteAccountReasonsPresentationModel();
    deleteAccountReasonsInitialParams = MockDeleteAccountReasonsInitialParams();
    deleteAccountReasonsNavigator = MockDeleteAccountReasonsNavigator();

    inviteFriendsPresenter = MockInviteFriendsPresenter();
    inviteFriendsPresentationModel = MockInviteFriendsPresentationModel();
    inviteFriendsInitialParams = MockInviteFriendsInitialParams();
    inviteFriendsNavigator = MockInviteFriendsNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getNotificationSettingsFailure = MockGetNotificationSettingsFailure();
    getNotificationSettingsUseCase = MockGetNotificationSettingsUseCase();
    getBlockListFailure = MockGetBlockListFailure();
    getBlockListUseCase = MockGetBlockListUseCase();

    requestDeleteAccountFailure = MockRequestDeleteAccountFailure();
    requestDeleteAccountUseCase = MockRequestDeleteAccountUseCase();

    updatePrivacySettingsFailure = MockUpdatePrivacySettingsFailure();
    updatePrivacySettingsUseCase = MockUpdatePrivacySettingsUseCase();

    getPrivacySettingsFailure = MockGetPrivacySettingsFailure();
    getPrivacySettingsUseCase = MockGetPrivacySettingsUseCase();

    updateNotificationSettingsFailure = MockUpdateNotificationSettingsFailure();
    updateNotificationSettingsUseCase = MockUpdateNotificationSettingsUseCase();

    getDeleteAccountReasonsFailure = MockGetDeleteAccountReasonsFailure();
    getDeleteAccountReasonsUseCase = MockGetDeleteAccountReasonsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    documentsRepository = MockDocumentsRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockSettingsHomePresenter());
    registerFallbackValue(MockSettingsHomePresentationModel());
    registerFallbackValue(MockSettingsHomeInitialParams());
    registerFallbackValue(MockSettingsHomeNavigator());
    registerFallbackValue(MockLanguagePresenter());
    registerFallbackValue(MockLanguagePresentationModel());
    registerFallbackValue(MockLanguageInitialParams());
    registerFallbackValue(MockLanguageNavigator());
    registerFallbackValue(MockBlockedListPresenter());
    registerFallbackValue(MockBlockedListPresentationModel());
    registerFallbackValue(MockBlockedListInitialParams());
    registerFallbackValue(MockBlockedListNavigator());
    registerFallbackValue(MockCommunityGuidelinesPresenter());
    registerFallbackValue(MockCommunityGuidelinesPresentationModel());
    registerFallbackValue(MockCommunityGuidelinesInitialParams());
    registerFallbackValue(MockCommunityGuidelinesNavigator());
    registerFallbackValue(MockGetVerifiedPresenter());
    registerFallbackValue(MockGetVerifiedPresentationModel());
    registerFallbackValue(MockGetVerifiedInitialParams());
    registerFallbackValue(MockGetVerifiedNavigator());
    registerFallbackValue(MockNotificationSettingsPresenter());
    registerFallbackValue(MockNotificationSettingsPresentationModel());
    registerFallbackValue(MockNotificationSettingsInitialParams());
    registerFallbackValue(MockNotificationSettingsNavigator());
    registerFallbackValue(MockPrivacySettingsPresenter());
    registerFallbackValue(MockPrivacySettingsPresentationModel());
    registerFallbackValue(MockPrivacySettingsInitialParams());
    registerFallbackValue(MockPrivacySettingsNavigator());
    registerFallbackValue(MockDeleteAccountPresenter());
    registerFallbackValue(MockDeleteAccountPresentationModel());
    registerFallbackValue(MockDeleteAccountInitialParams());
    registerFallbackValue(MockDeleteAccountNavigator());
    registerFallbackValue(MockDeleteAccountReasonsPresenter());
    registerFallbackValue(MockDeleteAccountReasonsPresentationModel());
    registerFallbackValue(MockDeleteAccountReasonsInitialParams());
    registerFallbackValue(MockDeleteAccountReasonsNavigator());

    registerFallbackValue(MockInviteFriendsPresenter());
    registerFallbackValue(MockInviteFriendsPresentationModel());
    registerFallbackValue(MockInviteFriendsInitialParams());
    registerFallbackValue(MockInviteFriendsNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetNotificationSettingsFailure());
    registerFallbackValue(MockGetNotificationSettingsUseCase());
    registerFallbackValue(MockGetBlockListFailure());
    registerFallbackValue(MockGetBlockListUseCase());

    registerFallbackValue(MockRequestDeleteAccountFailure());
    registerFallbackValue(MockRequestDeleteAccountUseCase());

    registerFallbackValue(MockUpdatePrivacySettingsFailure());
    registerFallbackValue(MockUpdatePrivacySettingsUseCase());

    registerFallbackValue(MockGetPrivacySettingsFailure());
    registerFallbackValue(MockGetPrivacySettingsUseCase());

    registerFallbackValue(MockUpdateNotificationSettingsFailure());
    registerFallbackValue(MockUpdateNotificationSettingsUseCase());

    registerFallbackValue(MockGetDeleteAccountReasonsFailure());
    registerFallbackValue(MockGetDeleteAccountReasonsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockDocumentsRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
