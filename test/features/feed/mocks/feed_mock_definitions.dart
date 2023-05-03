import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_navigator.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presenter.dart';
import 'package:picnic_app/features/feed/domain/model/get_feed_posts_failure.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import "package:picnic_app/features/feed/domain/model/get_popular_feed_failure.dart";
import 'package:picnic_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:picnic_app/features/feed/domain/stores/local_feeds_store.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_feeds_list_use_case.dart';
import "package:picnic_app/features/feed/domain/use_cases/get_popular_feed_use_case.dart";
import 'package:picnic_app/features/feed/feed_home/feed_home_initial_params.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_navigator.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presenter.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_navigator.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockFeedHomePresenter extends MockCubit<FeedHomeViewModel> implements FeedHomePresenter {}

class MockFeedHomePresentationModel extends Mock implements FeedHomePresentationModel {}

class MockFeedHomeInitialParams extends Mock implements FeedHomeInitialParams {}

class MockFeedHomeNavigator extends Mock implements FeedHomeNavigator {}

class MockFeedMorePresenter extends MockCubit<FeedMoreViewModel> implements FeedMorePresenter {}

class MockFeedMorePresentationModel extends Mock implements FeedMorePresentationModel {}

class MockFeedMoreInitialParams extends Mock implements FeedMoreInitialParams {}

class MockFeedMoreNavigator extends Mock implements FeedMoreNavigator {}

class MockCirclesSideMenuPresenter extends MockCubit<CirclesSideMenuViewModel> implements CirclesSideMenuPresenter {}

class MockCirclesSideMenuPresentationModel extends Mock implements CirclesSideMenuPresentationModel {}

class MockCirclesSideMenuInitialParams extends Mock implements CirclesSideMenuInitialParams {}

class MockCirclesSideMenuNavigator extends Mock implements CirclesSideMenuNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetFeedsListFailure extends Mock implements GetFeedsListFailure {}

class MockGetFeedsListUseCase extends Mock implements GetFeedsListUseCase {}

class MockGetFeedPostsFailure extends Mock implements GetFeedPostsFailure {}

class MockGetPopularFeedFailure extends Mock implements GetPopularFeedFailure {}

class MockGetPopularFeedUseCase extends Mock implements GetPopularFeedUseCase {}

class MockViewPostUseCase extends Mock implements ViewPostUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockFeedRepository extends Mock implements FeedRepository {}

//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
class MockLocalFeedsStore extends Mock implements LocalFeedsStore {}
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
