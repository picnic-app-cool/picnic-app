import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_private_profile_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_page.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../pods/mocks/pods_mocks.dart';
import '../../seeds/mocks/seeds_mocks.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late PrivateProfilePage page;
  late PrivateProfileInitialParams initParams;
  late PrivateProfilePresentationModel model;
  late PrivateProfilePresenter presenter;
  late PrivateProfileNavigator navigator;
  late GetCollectionsUseCase getCollectionsUseCase;
  late GetUserCirclesUseCase getUserCirclesUseCase;
  late GetPrivateProfileUseCase getPrivateProfileUseCase;
  late GetProfileStatsUseCase getProfileStatsUseCase;

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    initParams = const PrivateProfileInitialParams();
    model = PrivateProfilePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );
    navigator = PrivateProfileNavigator(Mocks.appNavigator);
    getCollectionsUseCase = GetCollectionsUseCase(Mocks.collectionsRepository);
    getUserCirclesUseCase = GetUserCirclesUseCase(Mocks.circlesRepository);
    getProfileStatsUseCase = GetProfileStatsUseCase(Mocks.usersRepository);
    getPrivateProfileUseCase = GetPrivateProfileUseCase(Mocks.privateProfileRepository);
    when(() => ProfileMocks.savedPostsRepository.getSavedPosts(nextPageCursor: any(named: "nextPageCursor")))
        .thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.firstPage(),
          items: [
            Stubs.imagePost,
            Stubs.imagePost,
            Stubs.imagePost,
            Stubs.imagePost,
          ],
        ),
      ),
    );

    when(
      () => Mocks.circlesRepository.getUserCircles(
        nextPageCursor: any(named: 'nextPageCursor'),
        roles: any(named: 'roles'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(() => Mocks.privateProfileRepository.getPrivateProfile())
        .thenAnswer((invocation) => successFuture(Stubs.privateProfile));

    when(() => Mocks.usersRepository.getProfileStats(userId: any(named: 'userId')))
        .thenAnswer((invocation) => successFuture(Stubs.profileStats));

    when(
      () => ProfileMocks.getUserPostsUseCase.execute(
        userId: any(named: 'userId'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.firstPage(),
          items: [
            Stubs.imagePost,
            Stubs.imagePost,
            Stubs.imagePost,
            Stubs.imagePost,
          ],
        ),
      ),
    );

    when(() => ProfileMocks.getUnreadNotificationsCountUseCase.execute()).thenAnswer(
      (invocation) => successFuture(const UnreadNotificationsCount(count: 7)),
    );

    when(
      () => Mocks.getContactsUseCase.execute(
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (_) => successFuture(
        Stubs.userContacts,
      ),
    );

    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
        .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));

    when(() => Mocks.uploadContactsUseCase.execute()).thenAnswer((invocation) => successFuture(unit));

    when(
      () => ProfileMocks.getSavedPostsUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(
      () => ProfileMocks.getSavedPostsUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(() => Mocks.updateAppBadgeCountUseCase.execute(any())).thenAnswer((_) => Future.value());

    presenter = PrivateProfilePresenter(
      model,
      navigator,
      getCollectionsUseCase,
      getUserCirclesUseCase,
      getPrivateProfileUseCase,
      ProfileMocks.getUserPostsUseCase,
      ProfileMocks.getUnreadNotificationsCountUseCase,
      getProfileStatsUseCase,
      Mocks.uploadContactsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.updateAppBadgeCountUseCase,
      Mocks.userStore,
      AnalyticsMocks.logAnalyticsEventUseCase,
      ProfileMocks.getSavedPostsUseCase,
      SeedsMocks.getUserSeedsTotalUseCase,
      Mocks.leaveCircleUseCase,
      Mocks.clipboardManager,
      PodsMocks.getSavedPodsUseCase,
      SeedsMocks.getSeedsUseCase,
    );
    when(
      () => SeedsMocks.getUserSeedsTotalUseCase.execute(),
    ).thenAnswer(
      (_) => successFuture(0),
    );

    page = PrivateProfilePage(presenter: presenter);
  }

  await screenshotTest(
    "private_profile_page",
    variantName: "collections_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "private_profile_page",
    variantName: "collections_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.collectionsEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "private_profile_page",
    variantName: "seeds_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.seedsProfileCircleEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "private_profile_page",
    variantName: "seeds_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.seedsProfileCircleEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    _initMvp();
    final page = getIt<PrivateProfilePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
