import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_stats.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/analytics_observer.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_page.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_page.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_page.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presenter.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_page.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presenter.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_page.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presenter.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_presenter.dart';
import 'package:picnic_app/features/in_app_events/unread_chats/unread_chats_presenter.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/main/main_page.dart';
import 'package:picnic_app/features/main/main_presentation_model.dart';
import 'package:picnic_app/features/main/main_presenter.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_page.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presenter.dart';
import 'package:picnic_app/navigation/utils/root_navigator_observer.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../../feed/mocks/feed_mocks.dart';
import '../../in_app_notifications/mocks/in_app_notifications_mocks.dart';
import '../../pods/mocks/pods_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../../push_notifications/mocks/push_notifications_mocks.dart';

Future<void> main() async {
  late MainPage page;
  late MainInitialParams initParams;
  late MainPresentationModel model;
  late MainPresenter presenter;
  late MainNavigator navigator;

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 9, 2));
    when(() => InAppNotificationsMocks.getInAppNotificationsUseCase.execute()).thenAnswer((_) {
      return Future.value(const Stream.empty());
    });
    when(() => Mocks.startUnreadChatsListeningUseCase.execute()).thenAnswer((_) {
      return Future.value(const Stream.empty());
    });
    when(() => PushNotificationsMocks.getPushNotificationsUseCase.execute()).thenAnswer((_) {
      return const Stream.empty();
    });
    when(
      () => ChatMocks.getUnreadChatsUseCase.execute(),
    ).thenAnswer((_) => successFuture(List.empty()));
    when(
      () => ProfileMocks.getUnreadNotificationsCountUseCase.execute(),
    ).thenAnswer((_) => successFuture(const UnreadNotificationsCount.empty()));

    when(
      () => PodsMocks.getSavedPodsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.empty()));

    when(
      () => Mocks.getCollectionsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.empty()));
    when(
      () => Mocks.updateAppBadgeCountUseCase.execute(any()),
    ).thenAnswer((_) => Future.value());
    when(() => Mocks.unreadCountersStore.unreadChats).thenReturn([Stubs.unreadChat]);
    when(
      () => CirclesMocks.getLastUsedCirclesUseCase.execute(
        cursor: any(named: 'cursor'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(
      () => Mocks.getUserStatsUseCase.execute(
        userId: any(named: 'userId'),
      ),
    ).thenAnswer((_) => successFuture(const UserStats.empty()));

    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    initParams = const MainInitialParams();
    model = MainPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
      Mocks.unreadCountersStore,
      Mocks.userStore,
    );
    navigator = MainNavigator(Mocks.appNavigator);
    presenter = MainPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.currentTimeProvider,
      Mocks.backgroundApiRepository,
      Mocks.userStore,
      Mocks.unreadCountersStore,
    );
    page = MainPage(presenter: presenter);
  }

  await screenshotTest(
    "main_page",
    setUp: () async {
      _initMvp();

      // just to be sure we don't accidentally use real pages and real backend calls inside the test
      await getIt.reset();
      getIt.registerFactory<RootNavigatorObserver>(() => RootNavigatorObserver());
      getIt.registerFactory<AnalyticsObserver>(() => MockAnalyticsObserver());
      getIt.registerFactory<FeedHomePage>(() => const _TestFeedHomePage());
      getIt.registerFactory<ChatTabsPage>(() => const _TestChatTabsPage());
      getIt.registerFactory<DiscoverExplorePage>(() => const _TestDiscoverExploreTabsPage());
      getIt.registerFactory<PrivateProfilePage>(() => const _TestPrivateProfileTabsPage());

      getIt.registerFactory<NotificationsPresenter>(
        () => NotificationsPresenter(
          InAppNotificationsMocks.inAppNotificationsNavigator,
          InAppNotificationsMocks.getInAppNotificationsUseCase,
          InAppNotificationsMocks.toggleInAppNotificationsUseCase,
          PushNotificationsMocks.getPushNotificationsUseCase,
          Mocks.addDeeplinkUseCase,
          Mocks.getUserUseCase,
          ProfileMocks.getUnreadNotificationsCountUseCase,
          Mocks.updateAppBadgeCountUseCase,
        ),
      );

      getIt.registerFactory<UnreadChatsPresenter>(
        () => UnreadChatsPresenter(
          Mocks.startUnreadChatsListeningUseCase,
          Mocks.unreadCountersStore,
        ),
      );

      final circlesSideMenuPresentationModel = CirclesSideMenuPresentationModel.initial(
        CirclesSideMenuInitialParams(
          onCircleSideMenuAction: () {},
        ),
        Mocks.userStore,
      );

      getIt.registerFactory<CirclesSideMenuPresenter>(
        () => CirclesSideMenuPresenter(
          circlesSideMenuPresentationModel,
          FeedMocks.circlesSideMenuNavigator,
          CirclesMocks.getLastUsedCirclesUseCase,
          Mocks.getCollectionsUseCase,
          PodsMocks.getSavedPodsUseCase,
          Mocks.getUserStatsUseCase,
        ),
      );
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await configureDependenciesForTests();
    _initMvp();
    final page = getIt<MainPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

//ignore: avoid_implementing_value_types
class _TestFeedHomePage extends StatefulWidget implements FeedHomePage {
  const _TestFeedHomePage({Key? key}) : super(key: key);

  @override
  State<_TestFeedHomePage> createState() => _TestFeedHomePageState();

  @override
  FeedHomePresenter get presenter => throw UnimplementedError();
}

class _TestFeedHomePageState extends State<_TestFeedHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("TEST FEED HOME PAGE"),
    );
  }
}

//ignore: avoid_implementing_value_types
class _TestChatTabsPage extends StatefulWidget implements ChatTabsPage {
  const _TestChatTabsPage({Key? key}) : super(key: key);

  @override
  State<_TestChatTabsPage> createState() => _TestChatTabsPageState();

  @override
  ChatTabsPresenter get presenter => throw UnimplementedError();

  @override
  ChatDmsPage get chatDmsPage => throw UnimplementedError();

  @override
  ChatFeedPage get chatFeedPage => throw UnimplementedError();
}

class _TestChatTabsPageState extends State<_TestChatTabsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("TEST CHAT TABS PAGE"),
    );
  }
}

//ignore: avoid_implementing_value_types
class _TestDiscoverExploreTabsPage extends StatefulWidget implements DiscoverExplorePage {
  const _TestDiscoverExploreTabsPage({Key? key}) : super(key: key);

  @override
  State<_TestDiscoverExploreTabsPage> createState() => _TestDiscoverExploreTabsPageState();

  @override
  DiscoverExplorePresenter get presenter => throw UnimplementedError();
}

class _TestDiscoverExploreTabsPageState extends State<_TestDiscoverExploreTabsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("TEST DISCOVER EXPLORE TABS PAGE"),
    );
  }
}

//ignore: avoid_implementing_value_types
class _TestPrivateProfileTabsPage extends StatefulWidget implements PrivateProfilePage {
  const _TestPrivateProfileTabsPage({Key? key}) : super(key: key);

  @override
  State<_TestPrivateProfileTabsPage> createState() => _TestPrivateProfileTabsPageState();

  @override
  PrivateProfilePresenter get presenter => throw UnimplementedError();
}

class _TestPrivateProfileTabsPageState extends State<_TestPrivateProfileTabsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("TEST DISCOVER EXPLORE TABS PAGE"),
    );
  }
}
