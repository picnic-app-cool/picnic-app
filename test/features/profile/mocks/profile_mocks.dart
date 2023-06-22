import 'package:mocktail/mocktail.dart';

import 'profile_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class ProfileMocks {
  // MVP

  static late MockPrivateProfilePresenter privateProfilePresenter;
  static late MockPrivateProfilePresentationModel privateProfilePresentationModel;
  static late MockPrivateProfileInitialParams privateProfileInitialParams;
  static late MockPrivateProfileNavigator privateProfileNavigator;
  static late MockNotificationsPresenter notificationsPresenter;
  static late MockNotificationsPresentationModel notificationsPresentationModel;
  static late MockNotificationsInitialParams notificationsInitialParams;
  static late MockNotificationsNavigator notificationsNavigator;
  static late MockFollowersPresenter followersPresenter;
  static late MockFollowersPresentationModel followersPresentationModel;
  static late MockFollowersInitialParams followersInitialParams;
  static late MockFollowersNavigator followersNavigator;
  static late MockSavedPostsPresenter savedPostsPresenter;
  static late MockSavedPostsPresentationModel savedPostsPresentationModel;
  static late MockSavedPostsInitialParams savedPostsInitialParams;
  static late MockSavedPostsNavigator savedPostsNavigator;
  static late MockEditProfilePresenter editProfilePresenter;
  static late MockEditProfilePresentationModel editProfilePresentationModel;
  static late MockEditProfileInitialParams editProfileInitialParams;
  static late MockEditProfileNavigator editProfileNavigator;
  static late MockPublicProfilePresenter publicProfilePresenter;
  static late MockPublicProfilePresentationModel publicProfilePresentationModel;
  static late MockPublicProfileInitialParams publicProfileInitialParams;
  static late MockPublicProfileNavigator publicProfileNavigator;

  static late MockCollectionPresenter collectionPresenter;
  static late MockCollectionPresentationModel collectionPresentationModel;
  static late MockCollectionInitialParams collectionInitialParams;
  static late MockCollectionNavigator collectionNavigator;

  static late MockInviteFriendsBottomSheetPresenter shareFriendsSheetPresenter;
  static late MockInviteFriendsBottomSheetPresentationModel shareFriendsSheetPresentationModel;
  static late MockInviteFriendsBottomSheetInitialParams shareFriendsSheetInitialParams;
  static late MockInviteFriendsBottomSheetNavigator shareFriendsSheetNavigator;

  static late MockProfileBottomSheetPresenter profileBottomSheetPresenter;
  static late MockProfileBottomSheetPresentationModel profileBottomSheetPresentationModel;
  static late MockProfileBottomSheetInitialParams profileBottomSheetInitialParams;
  static late MockProfileBottomSheetNavigator profileBottomSheetNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetSavedPostsFailure getSavedPostsFailure;
  static late MockGetSavedPostsUseCase getSavedPostsUseCase;

  static late MockGetFollowersFailure getFollowersFailure;
  static late MockGetFollowersUseCase getFollowersUseCase;

  static late MockGetPrivateProfileFailure getPrivateProfileFailure;
  static late MockGetPrivateProfileUseCase getPrivateProfileUseCase;

  static late MockGetPostsInCollectionFailure getPostsInCollectionFailure;
  static late MockGetPostsInCollectionUseCase getPostsInCollectionUseCase;

  static late MockGetNotificationsFailure getNotificationsFailure;
  static late MockGetNotificationsUseCase getNotificationsUseCase;

  static late MockGetUserPostsFailure getUserPostsFailure;
  static late MockGetUserPostsUseCase getUserPostsUseCase;

  static late MockEditProfileFailure editProfileFailure;
  static late MockEditProfileUseCase editProfileUseCase;

  static late MockUpdateProfileImageFailure updateProfileImageFailure;
  static late MockUpdateProfileImageUseCase updateProfileImageUseCase;

  static late MockGetProfileStatsFailure getProfileStatsFailure;
  static late MockGetProfileStatsUseCase getProfileStatsUseCase;

  static late MockDeleteCollectionFailure deleteCollectionFailure;
  static late MockDeleteCollectionUseCase deleteCollectionUseCase;

  static late MockRemoveCollectionPostsFailure removeCollectionPostsFailure;
  static late MockRemoveCollectionPostsUseCase removeCollectionPostsUseCase;

  static late MockGetUnreadNotificationsCountFailure getUnreadNotificationsCountFailure;
  static late MockGetUnreadNotificationsCountUseCase getUnreadNotificationsCountUseCase;

  static late MockCreateCollectionFailure createCollectionFailure;
  static late MockCreateCollectionUseCase createCollectionUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockSavedPostsRepository savedPostsRepository;

  static late MockGetUserPostsRepository getUserPostsRepository;

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
    privateProfilePresenter = MockPrivateProfilePresenter();
    privateProfilePresentationModel = MockPrivateProfilePresentationModel();
    privateProfileInitialParams = MockPrivateProfileInitialParams();
    privateProfileNavigator = MockPrivateProfileNavigator();
    notificationsPresenter = MockNotificationsPresenter();
    notificationsPresentationModel = MockNotificationsPresentationModel();
    notificationsInitialParams = MockNotificationsInitialParams();
    notificationsNavigator = MockNotificationsNavigator();
    followersPresenter = MockFollowersPresenter();
    followersPresentationModel = MockFollowersPresentationModel();
    followersInitialParams = MockFollowersInitialParams();
    followersNavigator = MockFollowersNavigator();
    savedPostsPresenter = MockSavedPostsPresenter();
    savedPostsPresentationModel = MockSavedPostsPresentationModel();
    savedPostsInitialParams = MockSavedPostsInitialParams();
    savedPostsNavigator = MockSavedPostsNavigator();
    editProfilePresenter = MockEditProfilePresenter();
    editProfilePresentationModel = MockEditProfilePresentationModel();
    editProfileInitialParams = MockEditProfileInitialParams();
    editProfileNavigator = MockEditProfileNavigator();
    publicProfilePresenter = MockPublicProfilePresenter();
    publicProfilePresentationModel = MockPublicProfilePresentationModel();
    publicProfileInitialParams = MockPublicProfileInitialParams();
    publicProfileNavigator = MockPublicProfileNavigator();
    collectionPresenter = MockCollectionPresenter();
    collectionPresentationModel = MockCollectionPresentationModel();
    collectionInitialParams = MockCollectionInitialParams();
    collectionNavigator = MockCollectionNavigator();

    shareFriendsSheetPresenter = MockInviteFriendsBottomSheetPresenter();
    shareFriendsSheetPresentationModel = MockInviteFriendsBottomSheetPresentationModel();
    shareFriendsSheetInitialParams = MockInviteFriendsBottomSheetInitialParams();
    shareFriendsSheetNavigator = MockInviteFriendsBottomSheetNavigator();

    profileBottomSheetPresenter = MockProfileBottomSheetPresenter();
    profileBottomSheetPresentationModel = MockProfileBottomSheetPresentationModel();
    profileBottomSheetInitialParams = MockProfileBottomSheetInitialParams();
    profileBottomSheetNavigator = MockProfileBottomSheetNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getSavedPostsFailure = MockGetSavedPostsFailure();
    getSavedPostsUseCase = MockGetSavedPostsUseCase();

    getFollowersFailure = MockGetFollowersFailure();
    getFollowersUseCase = MockGetFollowersUseCase();

    getPrivateProfileFailure = MockGetPrivateProfileFailure();
    getPrivateProfileUseCase = MockGetPrivateProfileUseCase();

    getPostsInCollectionFailure = MockGetPostsInCollectionFailure();
    getPostsInCollectionUseCase = MockGetPostsInCollectionUseCase();

    getUserPostsFailure = MockGetUserPostsFailure();
    getUserPostsUseCase = MockGetUserPostsUseCase();

    getNotificationsFailure = MockGetNotificationsFailure();
    getNotificationsUseCase = MockGetNotificationsUseCase();

    editProfileFailure = MockEditProfileFailure();
    editProfileUseCase = MockEditProfileUseCase();

    updateProfileImageFailure = MockUpdateProfileImageFailure();
    updateProfileImageUseCase = MockUpdateProfileImageUseCase();

    getProfileStatsFailure = MockGetProfileStatsFailure();
    getProfileStatsUseCase = MockGetProfileStatsUseCase();

    removeCollectionPostsFailure = MockRemoveCollectionPostsFailure();
    removeCollectionPostsUseCase = MockRemoveCollectionPostsUseCase();

    deleteCollectionFailure = MockDeleteCollectionFailure();
    deleteCollectionUseCase = MockDeleteCollectionUseCase();

    getUnreadNotificationsCountFailure = MockGetUnreadNotificationsCountFailure();
    getUnreadNotificationsCountUseCase = MockGetUnreadNotificationsCountUseCase();

    createCollectionFailure = MockCreateCollectionFailure();
    createCollectionUseCase = MockCreateCollectionUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    savedPostsRepository = MockSavedPostsRepository();
    getUserPostsRepository = MockGetUserPostsRepository();

//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockPrivateProfilePresenter());
    registerFallbackValue(MockPrivateProfilePresentationModel());
    registerFallbackValue(MockPrivateProfileInitialParams());
    registerFallbackValue(MockPrivateProfileNavigator());
    registerFallbackValue(MockNotificationsPresenter());
    registerFallbackValue(MockNotificationsPresentationModel());
    registerFallbackValue(MockNotificationsInitialParams());
    registerFallbackValue(MockNotificationsNavigator());
    registerFallbackValue(MockFollowersPresenter());
    registerFallbackValue(MockFollowersPresentationModel());
    registerFallbackValue(MockFollowersInitialParams());
    registerFallbackValue(MockFollowersNavigator());
    registerFallbackValue(MockSavedPostsPresenter());
    registerFallbackValue(MockSavedPostsPresentationModel());
    registerFallbackValue(MockSavedPostsInitialParams());
    registerFallbackValue(MockSavedPostsNavigator());
    registerFallbackValue(MockEditProfilePresenter());
    registerFallbackValue(MockEditProfilePresentationModel());
    registerFallbackValue(MockEditProfileInitialParams());
    registerFallbackValue(MockEditProfileNavigator());
    registerFallbackValue(MockPublicProfilePresenter());
    registerFallbackValue(MockPublicProfilePresentationModel());
    registerFallbackValue(MockPublicProfileInitialParams());
    registerFallbackValue(MockPublicProfileNavigator());
    registerFallbackValue(MockCollectionPresenter());
    registerFallbackValue(MockCollectionPresentationModel());
    registerFallbackValue(MockCollectionInitialParams());
    registerFallbackValue(MockCollectionNavigator());

    registerFallbackValue(MockInviteFriendsBottomSheetPresenter());
    registerFallbackValue(MockInviteFriendsBottomSheetPresentationModel());
    registerFallbackValue(MockInviteFriendsBottomSheetInitialParams());
    registerFallbackValue(MockInviteFriendsBottomSheetNavigator());

    registerFallbackValue(MockProfileBottomSheetPresenter());
    registerFallbackValue(MockProfileBottomSheetPresentationModel());
    registerFallbackValue(MockProfileBottomSheetInitialParams());
    registerFallbackValue(MockProfileBottomSheetNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetSavedPostsFailure());
    registerFallbackValue(MockGetSavedPostsUseCase());

    registerFallbackValue(MockGetFollowersFailure());
    registerFallbackValue(MockGetFollowersUseCase());

    registerFallbackValue(MockGetPrivateProfileFailure());
    registerFallbackValue(MockGetPrivateProfileUseCase());

    registerFallbackValue(MockGetPostsInCollectionFailure());
    registerFallbackValue(MockGetPostsInCollectionUseCase());

    registerFallbackValue(MockGetUserPostsFailure());
    registerFallbackValue(MockGetUserPostsUseCase());

    registerFallbackValue(MockGetNotificationsFailure());
    registerFallbackValue(MockGetNotificationsUseCase());

    registerFallbackValue(MockEditProfileFailure());
    registerFallbackValue(MockEditProfileUseCase());

    registerFallbackValue(MockUpdateProfileImageFailure());
    registerFallbackValue(MockUpdateProfileImageUseCase());

    registerFallbackValue(MockGetProfileStatsFailure());
    registerFallbackValue(MockGetProfileStatsUseCase());

    registerFallbackValue(MockSendGlitterBombFailure());
    registerFallbackValue(MockSendGlitterBombUseCase());

    registerFallbackValue(MockDeleteCollectionFailure());
    registerFallbackValue(MockDeleteCollectionUseCase());

    registerFallbackValue(MockRemoveCollectionPostsFailure());
    registerFallbackValue(MockRemoveCollectionPostsUseCase());

    registerFallbackValue(MockGetUnreadNotificationsCountFailure());
    registerFallbackValue(MockGetUnreadNotificationsCountUseCase());

    registerFallbackValue(MockCreateCollectionFailure());
    registerFallbackValue(MockCreateCollectionUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockSavedPostsRepository());
    registerFallbackValue(MockGetUserPostsRepository());

//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
