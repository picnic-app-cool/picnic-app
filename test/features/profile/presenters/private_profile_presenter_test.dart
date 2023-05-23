import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presenter.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../seeds/mocks/seeds_mocks.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late PrivateProfilePresentationModel model;
  late PrivateProfilePresenter presenter;
  late MockPrivateProfileNavigator navigator;

  test(
    'tapping on followers should open FollowersPage',
    () {
      // WHEN
      presenter.onTapStat(StatType.followers);

      // THEN
      verify(() => navigator.openFollowers(any()));
    },
  );

  test(
    'tapping on share circle link should open share dialog',
    () {
      // GIVEN
      const link = Stubs.linkUrl;

      // WHEN
      presenter.onTapShareCircleLink(link);

      // THEN
      verify(() => navigator.shareText(text: link));
    },
  );

  test(
    'tapping on edit profile should open EditProfilePage',
    () {
      // WHEN
      presenter.onTapEditProfile();

      // THEN
      verify(() => navigator.openEditProfile(any()));
    },
  );
  test(
    'tapping on search should open Discovery Explore',
    () {
      // GIVEN
      when(
        () => navigator.openDiscoverExplore(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapSearchCircles();

      // THEN
      verify(
        () => navigator.openDiscoverExplore(any()),
      );
    },
  );

  test(
    'tapping on open link should open webview',
    () {
      // GIVEN
      const link = Stubs.linkUrl;

      // WHEN
      presenter.openLink(link);

      // THEN
      verify(() => navigator.openWebView(link));
    },
  );

  test(
    'tapping on create post should open create PostCreationIndexPage',
    () {
      //GIVEN
      when(() => navigator.openPostCreation(any())).thenAnswer((invocation) {
        return Future.value();
      });
      // WHEN
      presenter.onTapCreatePost();

      // THEN
      verify(() => navigator.openPostCreation(any()));
    },
  );

  test(
    'tapping on seeds should open SeedsPage',
    () {
      // WHEN
      presenter.onTapSeeds();

      // THEN
      verify(() => navigator.openSeeds(any()));
    },
  );

  test(
    'tapping on circle details should open CircleDetailsPage',
    () {
      // WHEN
      presenter.onTapEnterCircle(Stubs.id);

      // THEN
      verify(() => navigator.openCircleDetails(any()));
    },
  );

  test(
    'tapping on post should open SingleFeedPage',
    () {
      // WHEN
      presenter.onTapViewPost(Stubs.linkPost);

      // THEN
      verify(() => navigator.openSingleFeed(any(), useRoot: any(named: 'useRoot')));
    },
  );

  test(
    'tapping on save post should open SingleFeedPage',
    () {
      // WHEN
      presenter.onTapViewSavedPost(Stubs.linkPost);

      // THEN
      verify(() => navigator.openSingleFeed(any(), useRoot: any(named: 'useRoot')));
    },
  );

  test(
    'tapping on settings should open SettingsHomePage',
    () {
      // WHEN
      presenter.onTapSettings();

      // THEN
      verifyNever(() async => navigator.openSettingsHome(SettingsHomeInitialParams(user: Stubs.user)));
    },
  );

  test(
    'tapping on notifications should open NotificationsListPage',
    () {
      presenter.onTapNotifications();
      verify(
        () => navigator.openNotifications(const NotificationsListInitialParams()),
      );
    },
  );

  test(
    'tapping on tab should change tab to selected one',
    () {
      const selectedTab = 2;

      presenter.onTabChanged(selectedTab);
      expect(presenter.state.selectedTab, PrivateProfileTab.collections);
    },
  );

  test(
    "onInit should call loading useCases",
    () async {
      await presenter.onInit();
      verify(() => ProfileMocks.getPrivateProfileUseCase.execute());
      verify(() => ProfileMocks.getProfileStatsUseCase.execute(userId: any(named: 'userId')));
      verify(() => SeedsMocks.getUserSeedsTotalUseCase.execute());
    },
  );

  setUp(() {
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
      Stubs.featureFlags.enable(FeatureFlagType.collectionsEnabled),
    );

    model = PrivateProfilePresentationModel.initial(
      const PrivateProfileInitialParams(),
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );
    navigator = MockPrivateProfileNavigator();

    when(
      () => Mocks.getCollectionsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
    when(() => Mocks.getCirclesUseCase.execute())
        .thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(
      () => SeedsMocks.getUserSeedsTotalUseCase.execute(),
    ).thenAnswer(
      (_) => successFuture(0),
    );
    when(
      () => Mocks.getUserCirclesUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
        userId: any(named: 'userId'),
        roles: any(named: 'roles'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
    when(
      () => ProfileMocks.getUserPostsUseCase.execute(
        userId: any(named: 'userId'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(() => ProfileMocks.getPrivateProfileUseCase.execute())
        .thenAnswer((invocation) => successFuture(Stubs.privateProfile));
    when(() => navigator.openFollowers(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.shareText(text: any(named: 'text'))).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openEditProfile(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openSavedPosts(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openWebView(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openSeeds(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openCircleDetails(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openSingleFeed(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openSingleFeed(any(), useRoot: any(named: 'useRoot'))).thenAnswer((invocation) {
      return Future.value();
    });

    when(() => ProfileMocks.getUnreadNotificationsCountUseCase.execute())
        .thenAnswer((invocation) => successFuture(const UnreadNotificationsCount(count: 7)));

    when(() => navigator.openNotifications(any())).thenAnswer((_) => successFuture(unit));

    when(() => ProfileMocks.getProfileStatsUseCase.execute(userId: any(named: 'userId')))
        .thenAnswer((invocation) => successFuture(Stubs.profileStats));

    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
        .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));

    when(() => Mocks.uploadContactsUseCase.execute()).thenAnswer((invocation) => successFuture(unit));

    when(
      () => ProfileMocks.getSavedPostsUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(() => ProfileMocks.getUnreadNotificationsCountUseCase.execute())
        .thenAnswer((invocation) => successFuture(const UnreadNotificationsCount(count: 7)));

    when(() => Mocks.updateAppBadgeCountUseCase.execute(any())).thenAnswer((_) => Future.value());

    presenter = PrivateProfilePresenter(
      model,
      navigator,
      Mocks.getCollectionsUseCase,
      Mocks.getUserCirclesUseCase,
      ProfileMocks.getPrivateProfileUseCase,
      ProfileMocks.getUserPostsUseCase,
      ProfileMocks.getUnreadNotificationsCountUseCase,
      ProfileMocks.getProfileStatsUseCase,
      Mocks.uploadContactsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.updateAppBadgeCountUseCase,
      Mocks.userStore,
      AnalyticsMocks.logAnalyticsEventUseCase,
      ProfileMocks.getSavedPostsUseCase,
      SeedsMocks.getUserSeedsTotalUseCase,
      Mocks.leaveCircleUseCase,
      Mocks.clipboardManager,
    );
  });
}
