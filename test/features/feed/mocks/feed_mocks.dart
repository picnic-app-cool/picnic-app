import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/feed/domain/stores/local_feeds_store.dart';

import 'feed_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class FeedMocks {
  // MVP

  static late MockFeedHomePresenter feedHomePresenter;
  static late MockFeedHomePresentationModel feedHomePresentationModel;
  static late MockFeedHomeInitialParams feedHomeInitialParams;
  static late MockFeedHomeNavigator feedHomeNavigator;

  static late MockFeedMorePresenter feedMorePresenter;
  static late MockFeedMorePresentationModel feedMorePresentationModel;
  static late MockFeedMoreInitialParams feedMoreInitialParams;
  static late MockFeedMoreNavigator feedMoreNavigator;

  static late MockCirclesSideMenuPresenter circlesSideMenuPresenter;
  static late MockCirclesSideMenuPresentationModel circlesSideMenuPresentationModel;
  static late MockCirclesSideMenuInitialParams circlesSideMenuInitialParams;
  static late MockCirclesSideMenuNavigator circlesSideMenuNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetFeedsListFailure getFeedsListFailure;
  static late MockGetFeedsListUseCase getFeedsListUseCase;
  static late MockGetFeedPostsFailure getFeedPostsFailure;

  static late MockGetPopularFeedFailure getPopularFeedFailure;
  static late MockGetPopularFeedUseCase getPopularFeedUseCase;
  static late MockViewPostUseCase getViewPostUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockFeedRepository feedRepository;

  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  static late LocalFeedsStore localFeedsStore;

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP

    feedHomePresenter = MockFeedHomePresenter();
    feedHomePresentationModel = MockFeedHomePresentationModel();
    feedHomeInitialParams = MockFeedHomeInitialParams();
    feedHomeNavigator = MockFeedHomeNavigator();

    feedMorePresenter = MockFeedMorePresenter();
    feedMorePresentationModel = MockFeedMorePresentationModel();
    feedMoreInitialParams = MockFeedMoreInitialParams();
    feedMoreNavigator = MockFeedMoreNavigator();
    circlesSideMenuPresenter = MockCirclesSideMenuPresenter();
    circlesSideMenuPresentationModel = MockCirclesSideMenuPresentationModel();
    circlesSideMenuInitialParams = MockCirclesSideMenuInitialParams();
    circlesSideMenuNavigator = MockCirclesSideMenuNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getFeedsListFailure = MockGetFeedsListFailure();
    getFeedsListUseCase = MockGetFeedsListUseCase();
    getFeedPostsFailure = MockGetFeedPostsFailure();
    getPopularFeedFailure = MockGetPopularFeedFailure();
    getPopularFeedUseCase = MockGetPopularFeedUseCase();
    getViewPostUseCase = MockViewPostUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    feedRepository = MockFeedRepository();
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    localFeedsStore = MockLocalFeedsStore();
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP

    registerFallbackValue(MockFeedHomePresenter());
    registerFallbackValue(MockFeedHomePresentationModel());
    registerFallbackValue(MockFeedHomeInitialParams());
    registerFallbackValue(MockFeedHomeNavigator());

    registerFallbackValue(MockFeedMorePresenter());
    registerFallbackValue(MockFeedMorePresentationModel());
    registerFallbackValue(MockFeedMoreInitialParams());
    registerFallbackValue(MockFeedMoreNavigator());
    registerFallbackValue(MockCirclesSideMenuPresenter());
    registerFallbackValue(MockCirclesSideMenuPresentationModel());
    registerFallbackValue(MockCirclesSideMenuInitialParams());
    registerFallbackValue(MockCirclesSideMenuNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetFeedsListFailure());
    registerFallbackValue(MockGetFeedsListUseCase());
    registerFallbackValue(MockGetFeedPostsFailure());

    registerFallbackValue(MockGetPopularFeedFailure());
    registerFallbackValue(MockGetPopularFeedUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockFeedRepository());
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    registerFallbackValue(LocalFeedsStore());
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
