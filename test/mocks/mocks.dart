import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/model/watch_query_options.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/model/secure_local_storage_key.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/core/utils/periodic_task_executor.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

import '../features/analytics/mocks/analytics_mocks.dart';
import '../features/app_init/mocks/app_init_mocks.dart';
import '../features/avatar_selection/mocks/avatar_selection_mocks.dart';
import '../features/chat/mocks/chat_mocks.dart';
import '../features/circles/mocks/circles_mocks.dart';
import '../features/connection_status/mocks/connection_status_mocks.dart';
import '../features/create_circle/mocks/create_circle_mocks.dart';
import '../features/debug/mocks/debug_mocks.dart';
import '../features/deeplink_handler/mocks/deeplink_handler_mocks.dart';
import '../features/discord/mocks/discord_mocks.dart';
import '../features/discover/mocks/discover_mocks.dart';
import '../features/feed/mocks/feed_mocks.dart';
import '../features/force_update/mocks/force_update_mocks.dart';
import '../features/image_picker/mocks/image_picker_mocks.dart';
import '../features/in_app_notifications/mocks/in_app_notifications_mocks.dart';
import '../features/loading_splash/mocks/loading_splash_mocks.dart';
import '../features/main/mocks/main_mocks.dart';
import '../features/media_picker/mocks/media_picker_mocks.dart';
import '../features/onboarding/mocks/onboarding_mocks.dart';
import '../features/package_info/mocks/store_mocks.dart';
import '../features/photo_editor/mocks/photo_editor_mocks.dart';
import '../features/pods/mocks/pods_mocks.dart';
import '../features/posts/mocks/posts_mock_definitions.dart';
import '../features/posts/mocks/posts_mocks.dart';
import '../features/profile/mocks/profile_mocks.dart';
import '../features/push_notifications/mocks/push_notifications_mocks.dart';
import '../features/remote_config_repository/mocks/remote_config_repository_mocks.dart';
import '../features/reports/mocks/reports_mocks.dart';
import '../features/seeds/mocks/seeds_mocks.dart';
import '../features/settings/mocks/settings_mocks.dart';
import '../features/slices/mocks/slices_mocks.dart';
import '../features/user_agreement/mocks/user_agreement_mocks.dart';
import '../features/video_editor/mocks/video_editor_mocks.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

import 'mock_definitions.dart';

class Mocks {
  static late MockAppNavigator appNavigator;

  // MVP
  static late MockAchievementsPresenter achievementsPresenter;
  static late MockAchievementsPresentationModel achievementsPresentationModel;
  static late MockAchievementsInitialParams achievementsInitialParams;
  static late MockAchievementsNavigator achievementsNavigator;

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES
  static late MockCheckUsernameAvailabilityFailure checkUsernameAvailabilityFailure;
  static late MockCheckUsernameAvailabilityUseCase checkUsernameAvailabilityUseCase;
  static late MockFollowUserFailure followUserFailure;
  static late MockFollowUserUseCase followUserUseCase;
  static late MockLoadAvatarBordersFailure loadAvatarBordersFailure;
  static late MockLoadAvatarBordersUseCase loadAvatarBordersUseCase;
  static late MockSaveAvatarBorderFailure saveAvatarBorderFailure;
  static late MockSaveAvatarBorderUseCase saveAvatarBorderUseCase;
  static late MockSendGlitterBombUseCase sendGlitterBombUseCase;

  static late MockGetRuntimePermissionStatusFailure getRuntimePermissionStatusFailure;
  static late MockGetRuntimePermissionStatusUseCase getRuntimePermissionStatusUseCase;
  static late MockRequestRuntimePermissionFailure requestRuntimePermissionFailure;
  static late MockRequestRuntimePermissionUseCase requestRuntimePermissionUseCase;
  static late MockGetAuthTokenFailure getAuthTokenFailure;
  static late MockGetAuthTokenUseCase getAuthTokenUseCase;

  static late MockGetUserFailure getUserFailure;
  static late MockGetUserUseCase getUserUseCase;
  static late MockSearchUsersUseCase searchUsersUseCase;

  static late MockGetLanguageFailure getLanguageFailure;
  static late MockGetLanguageUseCase getLanguagesListUseCase;

  static late MockGetCollectionsFailure getCollectionsFailure;
  static late MockGetCollectionsUseCase getCollectionsUseCase;
  static late MockGetCirclesFailure getCirclesFailure;
  static late MockGetCirclesUseCase getCirclesUseCase;
  static late MockGetUserCirclesFailure getUserCirclesFailure;
  static late MockGetUserCirclesUseCase getUserCirclesUseCase;

  static late MockBlockUserFailure blockUserFailure;
  static late MockBlockUserUseCase blockUserUseCase;

  static late MockUnblockUserFailure unblockUserFailure;
  static late MockUnblockUserUseCase unblockUserUseCase;

  static late MockLogOutFailure logOutFailure;
  static late MockLogOutUseCase logOutUseCase;

  static late MockControlAudioPlayUseCase controlAudioPlayUseCase;

  static late MockSavePostToCollectionUseCase savePostToCollectionUseCase;
  static late MockSavePostToCollectionFailure savePostToCollectionFailure;

  static late MockSetLanguageFailure setLanguageFailure;
  static late MockSetLanguageUseCase setLanguageUseCase;

  static late MockViewPostFailure viewPostFailure;
  static late MockViewPostUseCase viewPostUseCase;

  static late MockSavePostScreenTimeUseCase savePostScreenTimeUseCase;

  static late MockAcceptSeedsOfferFailure acceptSeedsOfferFailure;
  static late MockAcceptSeedsOfferUseCase acceptSeedsOfferUseCase;

  static late MockRejectSeedsOfferFailure rejectSeedsOfferFailure;
  static late MockRejectSeedsOfferUseCase rejectSeedsOfferUseCase;

  static late MockJoinCircleFailure joinCircleFailure;
  static late MockJoinCircleUseCase joinCircleUseCase;

  static late MockLeaveCircleFailure leaveCircleFailure;
  static late MockLeaveCircleUseCase leaveCircleUseCase;

  static late MockCancelSeedsOfferFailure cancelSeedsOfferFailure;
  static late MockCancelSeedsOfferUseCase cancelSeedsOfferUseCase;

  static late MockAddSessionExpiredListenerUseCase addSessionExpiredListenerUseCase;

  static late MockRemoveSessionExpiredListenerUseCase removeSessionExpiredListenerUseCase;

  static late MockGetFeatureFlagsFailure getFeatureFlagsFailure;
  static late MockGetFeatureFlagsUseCase getFeatureFlagsUseCase;

  static late MockUpdateCircleFailure updateCircleFailure;
  static late MockUpdateCircleUseCase updateCircleUseCase;

  static late MockGetPhoneGalleryAssetsFailure getPhoneGalleryAssetsFailure;
  static late MockGetPhoneGalleryAssetsUseCase getPhoneGalleryAssetsUseCase;

  static late MockGetAttachmentsUseCase getAttachmentsUseCase;

  static late MockResolveReportUseCase resolveReportUseCase;
  static late MockResolveReportFailure resolveReportFailure;

  static late MockUploadAttachmentUseCase uploadAttachmentUseCase;

  static late MockVideoThumbnailUseCase videoThumbnailUseCase;

  static late MockHapticFeedbackFailure hapticFeedbackFailure;
  static late MockHapticFeedbackUseCase hapticFeedbackUseCase;

  static late MockAddDeepLinkUseCase addDeeplinkUseCase;
  static late MockStartUnreadChatsListeningUseCase startUnreadChatsListeningUseCase;

  static late MockListenToDeepLinksUseCase listenToDeepLinksUseCase;

  static late MockGetSlicesFailure getSlicesFailure;

  static late MockGetSlicesUseCase getSlicesUseCase;
  static late MockGetSliceMemberByRoleUseCase getSliceMemberByRoleUseCase;
  static late MockGetSliceMembersFailure getSliceMembersFailure;

  static late MockUpdateSliceUseCase updateSliceUseCase;
  static late MockUpdateSliceFailure updateSliceFailure;

  static late MockSavePhotoToGalleryFailure savePhotoToGalleryFailure;
  static late MockSavePhotoToGalleryUseCase savePhotoToGalleryUseCase;
  static late MockSaveVideoToGalleryUseCase saveVideoToGalleryUseCase;
  static late MockImageWatermarkUseCase imageWatermarkUseCase;
  static late MockGetCircleStatsFailure getCircleStatsFailure;
  static late MockGetCircleStatsUseCase getCircleStatsUseCase;

  static late MockGetPostCreationCirclesFailure getPostCreationCirclesFailure;
  static late MockGetPostCreationCirclesUseCase getPostCreationCirclesUseCase;

  static late MockOpenNativeAppSettingsFailure openNativeAppSettingsFailure;
  static late MockOpenNativeAppSettingsUseCase openNativeAppSettingsUseCase;

  static late MockGetAppInfoFailure getAppInfoFailure;
  static late MockSetAppInfoUseCase setAppInfoUseCase;

  static late MockCopyTextFailure copyTextFailure;
  static late MockCopyTextUseCase copyTextUseCase;

  static late MockJoinSliceFailure joinSliceFailure;
  static late MockJoinSliceUseCase joinSliceUseCase;

  static late MockLeaveSliceFailure leaveSliceFailure;
  static late MockLeaveSliceUseCase leaveSliceUseCase;

  static late MockUpdateCurrentUserFailure updateCurrentUserFailure;
  static late MockUpdateCurrentUserUseCase updateCurrentUserUseCase;

  static late MockSharePostFailure sharePostFailure;
  static late MockSharePostUseCase sharePostUseCase;

  static late MockRecaptchaVerificationFailure recaptchaVerificationFailure;
  static late MockRecaptchaVerificationUseCase recaptchaVerificationUseCase;

  static late MockUploadContactsFailure uploadContactsFailure;
  static late MockUploadContactsUseCase uploadContactsUseCase;

  static late MockNotifyContactFailure notifyContactFailure;
  static late MockNotifyContactUseCase notifyContactUseCase;

  static late MockMentionUserFailure mentionUserFailure;
  static late MockMentionUserUseCase mentionUserUseCase;

  static late MockGetContactsUseCase getContactsUseCase;

  static late MockDeletePostsFailure deletePostsFailure;
  static late MockDeletePostsUseCase deletePostsUseCase;

  static late MockUpdateAppBadgeCountUseCase updateAppBadgeCountUseCase;

  static late MockIncrementAppBadgeCountUseCase incrementAppBadgeCountUseCase;

  static late MockGetPhoneContactsUseCase getPhoneContactsUseCase;

  static late MockSetShouldShowCirclesSelectionFailure setShouldShowCirclesSelectionFailure;
  static late MockSetShouldShowCirclesSelectionUseCase setShouldShowCirclesSelectionUseCase;

  static late MockGetShouldShowCirclesSelectionFailure getShouldShowCirclesSelectionFailure;
  static late MockGetShouldShowCirclesSelectionUseCase getShouldShowCirclesSelectionUseCase;

  static late MockAddPostToCollectionFailure addPostToCollectionFailure;
  static late MockAddPostToCollectionUseCase addPostToCollectionUseCase;

  static late MockGetUserByUsernameFailure getUserByUsernameFailure;
  static late MockGetUserByUsernameUseCase getUserByUsernameUseCase;

  static late MockGetCircleByNameFailure getCircleByNameFailure;
  static late MockGetCircleByNameUseCase getCircleByNameUseCase;

  static late MockGetUserScopedPodTokenFailure getUserScopedPodTokenFailure;
  static late MockGetUserScopedPodTokenUseCase getUserScopedPodTokenUseCase;
  static late MockGetTrendingPodsUseCase getTrendingPodsUseCase;
  static late MockSearchPodsUseCase searchPodsUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockAuthRepository authRepository;
  static late MockRuntimePermissionsRepository runtimePermissionsRepository;

  static late MockUsersRepository usersRepository;

  static late MockLocalStoreRepository localStoreRepository;

  static late MockSecureLocalStoreRepository secureLocalStoreRepository;

  static late MockBackgroundApiRepository backgroundApiRepository;

  static late MockPrivateProfileRepository privateProfileRepository;
  static late MockCollectionsRepository collectionsRepository;
  static late MockCirclesRepository circlesRepository;
  static late MockCirclePostsRepository circlePostsRepository;

  static late MockSeedsResRepository seedsRepository;

  static late MockAudioPlayerRepository audioPlayerRepository;

  static late MockSessionExpiredRepository sessionExpiredRepository;

  static late MockPhoneGalleryRepository phoneGalleryRepository;

  static late MockDownloadRepository downloadRepository;
  static late MockAttachmentRepository attachmentRepository;
  static late MockHapticRepository hapticRepository;
  static late MockDeepLinksRepository deepLinksRepository;
  static late MockFeatureFlagsRepository featureFlagsRepository;
  static late MockPostCreationCirclesRepository postCreationCirclesRepository;

  static late MockSlicesRepository slicesRepository;

  static late MockContactsRepository contactsRepository;

  static late MockGetContactsRepository getContactsRepository;

  static late MockAppInfoRepository appInfoRepository;

  static late MockRecaptchaRepository recaptchaRepository;

  static late MockAppBadgeRepository appBadgeRepository;

  static late MockConnectionStatusRepository connectionStatusRepository;

  static late MockCacheManagementRepository cacheManagementRepository;

  static late MockPostsRepository postsRepository;

  static late MockAuthTokenRepository authTokenRepository;

  static late MockPodsRepository podsRepository;
//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES
  static late MockUserStore userStore;
  static late MockUserCirclesStore userCirclesStore;
  static late MockAppInfoStore appInfoStore;
  static late MockUnreadCountersStore unreadCountersStore;

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static late MockDebouncer debouncer;
  static late MockThrottler throttler;
  static late MockPeriodicTaskExecutor periodicTaskExecutor;
  static late MockCurrentTimeProvider currentTimeProvider;
  static late MockFirebaseAuth firebaseAuth;
  static late MockGoogleSignIn googleSignIn;
  static late MockFirebaseActionsFactory firebaseActionsFactory;
  static late MockGraphQLClient graphQlClient;
  static late MockLogInWithPhoneAction logInWithPhoneAction;
  static late MockUserCredential userCredential;
  static late MockFirebaseUser firebaseUser;
  static late MockClipboardManager clipboardManager;
  static late MockSessionInvalidatedListenersContainer sessionInvalidatedListenersContainer;
  static late MockFeatureFlagsStore featureFlagsStore;
  static late MockVideoMuteStore videoMuteStore;
  static late MockPicnicCameraController cameraController;
  static late MockEnvironmentConfigProvider environmentConfigProvider;
  static late MockDevicePlatformProvider devicePlatformProvider;
  static late MockImglyWrapper imglyWrapper;
  static late MockAssetsLoader assetsLoader;
  static late MockFxEffect fxEffect;
  static late MockAnalyticsObserver analyticsObserver;
  static late MockSharedPreferencesProvider sharedPreferencesProvider;
  static late MockSharedPreferences sharedPreferences;
  static late MockUserPreferencesRepository userPreferencesRepository;
  static late MockDioClient dioClient;

  static void init() {
    OnboardingMocks.init();
    FeedMocks.init();
    AppInitMocks.init();
    ProfileMocks.init();
    SettingsMocks.init();
    AvatarSelectionMocks.init();
    ChatMocks.init();
    CirclesMocks.init();
    DiscoverMocks.init();
    PhotoEditorMocks.init();
    ImagePickerMocks.init();
    MediaPickerMocks.init();
    PushNotificationsMocks.init();
    VideoEditorMocks.init();
    SeedsMocks.init();
    PostsMocks.init();
    MainMocks.init();
    ReportsMocks.init();
    DebugMocks.init();
    CreateCircleMocks.init();
    SystemEventHandlerMocks.init();
    InAppNotificationsMocks.init();
    LoadingSplashMocks.init();
    AnalyticsMocks.init();
    SlicesMocks.init();
    ForceUpdateMocks.init();
    RemoteConfigRepositoryMocks.init();
    StoreMocks.init();
    UserAgreementMocks.init();
    ConnectionStatusMocks.init();
    DiscordMocks.init();
    PodsMocks.init();
//DO-NOT-REMOVE FEATURE_MOCKS_INIT

    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    appNavigator = MockAppNavigator();
    // MVP
    achievementsPresenter = MockAchievementsPresenter();
    achievementsPresentationModel = MockAchievementsPresentationModel();
    achievementsInitialParams = MockAchievementsInitialParams();
    achievementsNavigator = MockAchievementsNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    checkUsernameAvailabilityFailure = MockCheckUsernameAvailabilityFailure();
    checkUsernameAvailabilityUseCase = MockCheckUsernameAvailabilityUseCase();
    loadAvatarBordersFailure = MockLoadAvatarBordersFailure();
    loadAvatarBordersUseCase = MockLoadAvatarBordersUseCase();
    saveAvatarBorderFailure = MockSaveAvatarBorderFailure();
    saveAvatarBorderUseCase = MockSaveAvatarBorderUseCase();
    sendGlitterBombUseCase = MockSendGlitterBombUseCase();
    getRuntimePermissionStatusFailure = MockGetRuntimePermissionStatusFailure();
    getRuntimePermissionStatusUseCase = MockGetRuntimePermissionStatusUseCase();
    requestRuntimePermissionFailure = MockRequestRuntimePermissionFailure();
    requestRuntimePermissionUseCase = MockRequestRuntimePermissionUseCase();
    getUserFailure = MockGetUserFailure();
    getUserUseCase = MockGetUserUseCase();
    searchUsersUseCase = MockSearchUsersUseCase();
    getLanguageFailure = MockGetLanguageFailure();
    getLanguagesListUseCase = MockGetLanguageUseCase();
    getCollectionsFailure = MockGetCollectionsFailure();
    getCollectionsUseCase = MockGetCollectionsUseCase();
    getCirclesFailure = MockGetCirclesFailure();
    getCirclesUseCase = MockGetCirclesUseCase();
    getUserCirclesFailure = MockGetUserCirclesFailure();
    getUserCirclesUseCase = MockGetUserCirclesUseCase();
    followUserFailure = MockFollowUserFailure();
    followUserUseCase = MockFollowUserUseCase();
    blockUserFailure = MockBlockUserFailure();
    blockUserUseCase = MockBlockUserUseCase();
    controlAudioPlayUseCase = MockControlAudioPlayUseCase();

    logOutFailure = MockLogOutFailure();
    logOutUseCase = MockLogOutUseCase();

    unblockUserFailure = MockUnblockUserFailure();
    unblockUserUseCase = MockUnblockUserUseCase();

    savePostToCollectionFailure = MockSavePostToCollectionFailure();
    savePostToCollectionUseCase = MockSavePostToCollectionUseCase();

    setLanguageFailure = MockSetLanguageFailure();
    setLanguageUseCase = MockSetLanguageUseCase();

    viewPostUseCase = MockViewPostUseCase();
    viewPostFailure = MockViewPostFailure();

    savePostScreenTimeUseCase = MockSavePostScreenTimeUseCase();

    joinCircleFailure = MockJoinCircleFailure();
    joinCircleUseCase = MockJoinCircleUseCase();

    leaveCircleFailure = MockLeaveCircleFailure();
    leaveCircleUseCase = MockLeaveCircleUseCase();

    cancelSeedsOfferFailure = MockCancelSeedsOfferFailure();
    cancelSeedsOfferUseCase = MockCancelSeedsOfferUseCase();

    rejectSeedsOfferFailure = MockRejectSeedsOfferFailure();
    rejectSeedsOfferUseCase = MockRejectSeedsOfferUseCase();

    acceptSeedsOfferFailure = MockAcceptSeedsOfferFailure();
    acceptSeedsOfferUseCase = MockAcceptSeedsOfferUseCase();

    addSessionExpiredListenerUseCase = MockAddSessionExpiredListenerUseCase();

    removeSessionExpiredListenerUseCase = MockRemoveSessionExpiredListenerUseCase();

    getFeatureFlagsFailure = MockGetFeatureFlagsFailure();
    getFeatureFlagsUseCase = MockGetFeatureFlagsUseCase();

    updateCircleFailure = MockUpdateCircleFailure();
    updateCircleUseCase = MockUpdateCircleUseCase();

    resolveReportFailure = MockResolveReportFailure();
    resolveReportUseCase = MockResolveReportUseCase();

    getPhoneGalleryAssetsFailure = MockGetPhoneGalleryAssetsFailure();
    getPhoneGalleryAssetsUseCase = MockGetPhoneGalleryAssetsUseCase();
    getAttachmentsUseCase = MockGetAttachmentsUseCase();

    uploadAttachmentUseCase = MockUploadAttachmentUseCase();

    videoThumbnailUseCase = MockVideoThumbnailUseCase();

    hapticFeedbackFailure = MockHapticFeedbackFailure();
    hapticFeedbackUseCase = MockHapticFeedbackUseCase();

    addDeeplinkUseCase = MockAddDeepLinkUseCase();

    startUnreadChatsListeningUseCase = MockStartUnreadChatsListeningUseCase();

    listenToDeepLinksUseCase = MockListenToDeepLinksUseCase();

    savePhotoToGalleryFailure = MockSavePhotoToGalleryFailure();
    savePhotoToGalleryUseCase = MockSavePhotoToGalleryUseCase();
    saveVideoToGalleryUseCase = MockSaveVideoToGalleryUseCase();
    imageWatermarkUseCase = MockImageWatermarkUseCase();
    getCircleStatsFailure = MockGetCircleStatsFailure();
    getCircleStatsUseCase = MockGetCircleStatsUseCase();

    getPostCreationCirclesFailure = MockGetPostCreationCirclesFailure();
    getPostCreationCirclesUseCase = MockGetPostCreationCirclesUseCase();

    getSlicesUseCase = MockGetSlicesUseCase();
    getSliceMemberByRoleUseCase = MockGetSliceMemberByRoleUseCase();
    getSliceMembersFailure = MockGetSliceMembersFailure();

    updateSliceUseCase = MockUpdateSliceUseCase();
    updateSliceFailure = MockUpdateSliceFailure();

    openNativeAppSettingsFailure = MockOpenNativeAppSettingsFailure();
    openNativeAppSettingsUseCase = MockOpenNativeAppSettingsUseCase();

    getAppInfoFailure = MockGetAppInfoFailure();
    setAppInfoUseCase = MockSetAppInfoUseCase();

    copyTextFailure = MockCopyTextFailure();
    copyTextUseCase = MockCopyTextUseCase();

    joinSliceFailure = MockJoinSliceFailure();
    joinSliceUseCase = MockJoinSliceUseCase();

    leaveSliceFailure = MockLeaveSliceFailure();
    leaveSliceUseCase = MockLeaveSliceUseCase();

    updateCurrentUserFailure = MockUpdateCurrentUserFailure();
    updateCurrentUserUseCase = MockUpdateCurrentUserUseCase();

    sharePostFailure = MockSharePostFailure();
    sharePostUseCase = MockSharePostUseCase();

    recaptchaVerificationFailure = MockRecaptchaVerificationFailure();
    recaptchaVerificationUseCase = MockRecaptchaVerificationUseCase();

    uploadContactsFailure = MockUploadContactsFailure();
    uploadContactsUseCase = MockUploadContactsUseCase();

    notifyContactFailure = MockNotifyContactFailure();
    notifyContactUseCase = MockNotifyContactUseCase();

    mentionUserFailure = MockMentionUserFailure();
    mentionUserUseCase = MockMentionUserUseCase();

    getContactsUseCase = MockGetContactsUseCase();

    deletePostsFailure = MockDeletePostsFailure();
    deletePostsUseCase = MockDeletePostsUseCase();

    updateAppBadgeCountUseCase = MockUpdateAppBadgeCountUseCase();

    incrementAppBadgeCountUseCase = MockIncrementAppBadgeCountUseCase();

    getPhoneContactsUseCase = MockGetPhoneContactsUseCase();

    setShouldShowCirclesSelectionFailure = MockSetShouldShowCirclesSelectionFailure();
    setShouldShowCirclesSelectionUseCase = MockSetShouldShowCirclesSelectionUseCase();

    setShouldShowCirclesSelectionFailure = MockSetShouldShowCirclesSelectionFailure();
    setShouldShowCirclesSelectionUseCase = MockSetShouldShowCirclesSelectionUseCase();

    getShouldShowCirclesSelectionFailure = MockGetShouldShowCirclesSelectionFailure();
    getShouldShowCirclesSelectionUseCase = MockGetShouldShowCirclesSelectionUseCase();

    addPostToCollectionFailure = MockAddPostToCollectionFailure();
    addPostToCollectionUseCase = MockAddPostToCollectionUseCase();

    getUserByUsernameFailure = MockGetUserByUsernameFailure();
    getUserByUsernameUseCase = MockGetUserByUsernameUseCase();

    getCircleByNameFailure = MockGetCircleByNameFailure();
    getCircleByNameUseCase = MockGetCircleByNameUseCase();

    getAuthTokenFailure = MockGetAuthTokenFailure();
    getAuthTokenUseCase = MockGetAuthTokenUseCase();

    getUserScopedPodTokenFailure = MockGetUserScopedPodTokenFailure();
    getUserScopedPodTokenUseCase = MockGetUserScopedPodTokenUseCase();
    getTrendingPodsUseCase = MockGetTrendingPodsUseCase();
    searchPodsUseCase = MockSearchPodsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    authRepository = MockAuthRepository();
    runtimePermissionsRepository = MockRuntimePermissionsRepository();
    usersRepository = MockUsersRepository();
    localStoreRepository = MockLocalStoreRepository();
    secureLocalStoreRepository = MockSecureLocalStoreRepository();
    backgroundApiRepository = MockBackgroundApiRepository();
    privateProfileRepository = MockPrivateProfileRepository();
    collectionsRepository = MockCollectionsRepository();
    circlesRepository = MockCirclesRepository();
    circlePostsRepository = MockCirclePostsRepository();
    seedsRepository = MockSeedsResRepository();
    audioPlayerRepository = MockAudioPlayerRepository();
    sessionExpiredRepository = MockSessionExpiredRepository();
    phoneGalleryRepository = MockPhoneGalleryRepository();
    downloadRepository = MockDownloadRepository();
    attachmentRepository = MockAttachmentRepository();
    hapticRepository = MockHapticRepository();
    deepLinksRepository = MockDeepLinksRepository();
    featureFlagsRepository = MockFeatureFlagsRepository();
    postCreationCirclesRepository = MockPostCreationCirclesRepository();
    slicesRepository = MockSlicesRepository();
    appInfoRepository = MockAppInfoRepository();

    appInfoRepository = MockAppInfoRepository();
    recaptchaRepository = MockRecaptchaRepository();
    contactsRepository = MockContactsRepository();
    getContactsRepository = MockGetContactsRepository();
    contactsRepository = MockContactsRepository();
    appBadgeRepository = MockAppBadgeRepository();
    connectionStatusRepository = MockConnectionStatusRepository();

    cacheManagementRepository = MockCacheManagementRepository();
    postsRepository = MockPostsRepository();
    authTokenRepository = MockAuthTokenRepository();
    podsRepository = MockPodsRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    userStore = MockUserStore();
    userCirclesStore = MockUserCirclesStore();
    appInfoStore = MockAppInfoStore();
    unreadCountersStore = MockUnreadCountersStore();
    //DO-NOT-REMOVE STORES_INIT_MOCKS

    debouncer = MockDebouncer();
    throttler = MockThrottler();
    periodicTaskExecutor = MockPeriodicTaskExecutor();
    currentTimeProvider = MockCurrentTimeProvider();
    firebaseAuth = MockFirebaseAuth();
    googleSignIn = MockGoogleSignIn();
    firebaseActionsFactory = MockFirebaseActionsFactory();
    sessionInvalidatedListenersContainer = MockSessionInvalidatedListenersContainer();
    graphQlClient = MockGraphQLClient();
    logInWithPhoneAction = MockLogInWithPhoneAction();
    userCredential = MockUserCredential();
    firebaseUser = MockFirebaseUser();
    clipboardManager = MockClipboardManager();
    featureFlagsStore = MockFeatureFlagsStore();
    videoMuteStore = MockVideoMuteStore();
    cameraController = MockPicnicCameraController();
    environmentConfigProvider = MockEnvironmentConfigProvider();
    devicePlatformProvider = MockDevicePlatformProvider();
    imglyWrapper = MockImglyWrapper();
    assetsLoader = MockAssetsLoader();
    fxEffect = MockFxEffect();
    analyticsObserver = MockAnalyticsObserver();
    sharedPreferencesProvider = MockSharedPreferencesProvider();
    sharedPreferences = MockSharedPreferences();
    userPreferencesRepository = MockUserPreferencesRepository();
    dioClient = MockDioClient();
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    registerFallbackValue(DisplayableFailure(title: '', message: ''));
    // MVP
    registerFallbackValue(MockAchievementsPresenter());
    registerFallbackValue(MockAchievementsPresentationModel());
    registerFallbackValue(MockAchievementsInitialParams());
    registerFallbackValue(MockAchievementsNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockCheckUsernameAvailabilityFailure());
    registerFallbackValue(MockCheckUsernameAvailabilityUseCase());
    registerFallbackValue(MockLoadAvatarBordersFailure());
    registerFallbackValue(MockLoadAvatarBordersUseCase());
    registerFallbackValue(MockSaveAvatarBorderFailure());
    registerFallbackValue(MockSaveAvatarBorderUseCase());
    registerFallbackValue(MockGetRuntimePermissionStatusFailure());
    registerFallbackValue(MockGetRuntimePermissionStatusUseCase());
    registerFallbackValue(MockRequestRuntimePermissionFailure());
    registerFallbackValue(MockRequestRuntimePermissionUseCase());
    registerFallbackValue(MockGetUserFailure());
    registerFallbackValue(MockGetUserUseCase());
    registerFallbackValue(MockGetLanguageUseCase());
    registerFallbackValue(MockGetLanguageFailure());
    registerFallbackValue(MockGetCollectionsFailure());
    registerFallbackValue(MockGetCollectionsUseCase());
    registerFallbackValue(MockGetCirclesFailure());
    registerFallbackValue(MockGetCirclesUseCase());
    registerFallbackValue(MockBlockUserFailure());
    registerFallbackValue(MockBlockUserUseCase());
    registerFallbackValue(MockFollowUserFailure());
    registerFallbackValue(MockFollowUserUseCase());

    registerFallbackValue(MockUnblockUserFailure());
    registerFallbackValue(MockUnblockUserUseCase());

    registerFallbackValue(MockLogOutFailure());
    registerFallbackValue(MockLogOutUseCase());

    registerFallbackValue(MockSavePostToCollectionFailure());
    registerFallbackValue(MockSavePostToCollectionUseCase());

    registerFallbackValue(MockSetLanguageFailure());
    registerFallbackValue(MockSetLanguageUseCase());

    registerFallbackValue(MockRejectSeedsOfferFailure());
    registerFallbackValue(MockRejectSeedsOfferUseCase());

    registerFallbackValue(MockJoinCircleFailure());
    registerFallbackValue(MockJoinCircleUseCase());

    registerFallbackValue(MockLeaveCircleFailure());
    registerFallbackValue(MockLeaveCircleUseCase());

    registerFallbackValue(MockCancelSeedsOfferFailure());
    registerFallbackValue(MockCancelSeedsOfferUseCase());

    registerFallbackValue(MockAcceptSeedsOfferFailure());
    registerFallbackValue(MockAcceptSeedsOfferUseCase());
    registerFallbackValue(MockAddSessionExpiredListenerUseCase());
    registerFallbackValue(MockRemoveSessionExpiredListenerUseCase());

    registerFallbackValue(MockGetFeatureFlagsFailure());
    registerFallbackValue(MockGetFeatureFlagsUseCase());

    registerFallbackValue(MockUpdateCircleFailure());
    registerFallbackValue(MockUpdateCircleUseCase());

    registerFallbackValue(MockGetPhoneGalleryAssetsFailure());
    registerFallbackValue(MockGetPhoneGalleryAssetsUseCase());

    registerFallbackValue(MockResolveReportFailure());
    registerFallbackValue(MockResolveReportUseCase());

    registerFallbackValue(MockHapticFeedbackFailure());
    registerFallbackValue(MockHapticFeedbackUseCase());

    registerFallbackValue(MockAddDeepLinkUseCase());

    registerFallbackValue(MockListenToDeepLinksUseCase());

    registerFallbackValue(MockSavePhotoToGalleryFailure());
    registerFallbackValue(MockSavePhotoToGalleryUseCase());
    registerFallbackValue(MockGetCircleStatsFailure());
    registerFallbackValue(MockGetCircleStatsUseCase());

    registerFallbackValue(MockGetSlicesFailure());
    registerFallbackValue(MockGetSlicesUseCase());

    registerFallbackValue(MockFxEffect());

    registerFallbackValue(MockGetPostCreationCirclesFailure());
    registerFallbackValue(MockGetPostCreationCirclesUseCase());

    registerFallbackValue(MockOpenNativeAppSettingsFailure());
    registerFallbackValue(MockOpenNativeAppSettingsUseCase());

    registerFallbackValue(MockGetAppInfoFailure());
    registerFallbackValue(MockSetAppInfoUseCase());

    registerFallbackValue(MockCopyTextFailure());
    registerFallbackValue(MockCopyTextUseCase());

    registerFallbackValue(MockGetSliceMemberByRoleUseCase());
    registerFallbackValue(MockGetSliceMembersFailure());

    registerFallbackValue(MockUpdateSliceFailure());
    registerFallbackValue(MockUpdateSliceUseCase());

    registerFallbackValue(MockJoinSliceFailure());
    registerFallbackValue(MockJoinSliceUseCase());

    registerFallbackValue(MockUpdateSliceFailure());
    registerFallbackValue(MockUpdateSliceUseCase());

    registerFallbackValue(MockLeaveSliceFailure());
    registerFallbackValue(MockLeaveSliceUseCase());

    registerFallbackValue(MockUpdateCurrentUserFailure());
    registerFallbackValue(MockUpdateCurrentUserUseCase());

    registerFallbackValue(MockSharePostFailure());
    registerFallbackValue(MockSharePostUseCase());

    registerFallbackValue(MockRecaptchaVerificationFailure());
    registerFallbackValue(MockRecaptchaVerificationUseCase());

    registerFallbackValue(MockUploadContactsFailure());
    registerFallbackValue(MockUploadContactsUseCase());

    registerFallbackValue(MockNotifyContactFailure());
    registerFallbackValue(MockNotifyContactUseCase());

    registerFallbackValue(MockMentionUserFailure());
    registerFallbackValue(MockMentionUserUseCase());

    registerFallbackValue(MockGetContactsUseCase());

    registerFallbackValue(MockDeletePostsFailure());
    registerFallbackValue(MockDeletePostsUseCase());

    registerFallbackValue(MockUpdateAppBadgeCountUseCase());

    registerFallbackValue(MockIncrementAppBadgeCountUseCase());

    registerFallbackValue(MockGetPhoneContactsUseCase());

    registerFallbackValue(MockSetShouldShowCirclesSelectionFailure());
    registerFallbackValue(MockSetShouldShowCirclesSelectionUseCase());

    registerFallbackValue(MockSetShouldShowCirclesSelectionFailure());
    registerFallbackValue(MockSetShouldShowCirclesSelectionUseCase());

    registerFallbackValue(MockGetShouldShowCirclesSelectionFailure());
    registerFallbackValue(MockGetShouldShowCirclesSelectionUseCase());

    registerFallbackValue(MockAddPostToCollectionFailure());
    registerFallbackValue(MockAddPostToCollectionUseCase());

    registerFallbackValue(MockGetUserByUsernameFailure());
    registerFallbackValue(MockGetUserByUsernameUseCase());

    registerFallbackValue(MockGetCircleByNameFailure());
    registerFallbackValue(MockGetCircleByNameUseCase());

    registerFallbackValue(MockGetUserScopedPodTokenFailure());
    registerFallbackValue(MockGetUserScopedPodTokenUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockAuthRepository());
    registerFallbackValue(MockRuntimePermissionsRepository());
    registerFallbackValue(MockUsersRepository());
    registerFallbackValue(MockLocalStoreRepository());
    registerFallbackValue(MockPrivateProfileRepository());
    registerFallbackValue(MockCollectionsRepository());
    registerFallbackValue(MockCirclesRepository());
    registerFallbackValue(MockSeedsResRepository());
    registerFallbackValue(MockSessionExpiredRepository());
    registerFallbackValue(MockPhoneGalleryRepository());
    registerFallbackValue(MockHapticRepository());
    registerFallbackValue(MockDeepLinksRepository());
    registerFallbackValue(MockSlicesRepository());
    registerFallbackValue(MockContactsRepository());

    registerFallbackValue(MockFeatureFlagsRepository());
    registerFallbackValue(MockPostCreationCirclesRepository());
    registerFallbackValue(MockGetContactsRepository());
    registerFallbackValue(MockContactsRepository());
    registerFallbackValue(MockAppInfoRepository());
    registerFallbackValue(MockRecaptchaRepository());
    registerFallbackValue(MockAppBadgeRepository());
    registerFallbackValue(MockConnectionStatusRepository());
    registerFallbackValue(MockCacheManagementRepository());
    registerFallbackValue(MockAuthTokenRepository());
    registerFallbackValue(MockPodsRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    registerFallbackValue(MockUserStore());
    registerFallbackValue(MockAppInfoStore());
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE

    registerFallbackValue(materialRoute(Container()));
    registerFallbackValue(MockDebouncer());
    registerFallbackValue(MockThrottler());
    registerFallbackValue(MockCurrentTimeProvider());
    registerFallbackValue(PeriodicTaskExecutor());
    registerFallbackValue(RuntimePermission.notifications);
    registerFallbackValue(RuntimePermissionStatus.granted);
    registerFallbackValue(const PhoneVerificationData.empty());
    registerFallbackValue(const AuthResult.empty());
    registerFallbackValue(const Id.none());
    registerFallbackValue(MockFirebaseAuth());
    registerFallbackValue(MockGoogleSignIn());
    registerFallbackValue(MockFirebaseActionsFactory());
    registerFallbackValue(MockGraphQLClient());
    registerFallbackValue(MockLogInWithPhoneAction());
    registerFallbackValue(MockUserCredential());
    registerFallbackValue(MockFirebaseUser());
    registerFallbackValue(const Collection.empty());
    registerFallbackValue(MockClipboardManager());
    registerFallbackValue(MockFeatureFlagsStore());
    registerFallbackValue(MockVideoMuteStore());
    registerFallbackValue(SecureLocalStorageKey.gqlAccessToken);
    registerFallbackValue(MockEnvironmentConfigProvider());
    registerFallbackValue(MockDevicePlatformProvider());
    registerFallbackValue(MockImglyWrapper());
    registerFallbackValue(MockAssetsLoader());
    registerFallbackValue(const Attachment.empty());
    registerFallbackValue(const UploadAttachment.empty());
    registerFallbackValue(MockSharedPreferencesProvider());
    registerFallbackValue(MockSharedPreferences());
    registerFallbackValue(MockUserPreferencesRepository());
    registerFallbackValue(ConfirmationAction(title: "", action: () {}));
    registerFallbackValue(Uri.parse(""));
    registerFallbackValue(MockLocalStorageValueListener<String>());
    registerFallbackValue(const WatchQueryOptions.defaultOptions());
    registerFallbackValue(Duration.zero);
    registerFallbackValue(const CreateCollectionInput.empty());
    registerFallbackValue(const AuthToken.empty());
    registerFallbackValue(const SearchPodInput.empty());
  }
}
