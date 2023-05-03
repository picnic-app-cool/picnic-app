import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/block_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_page.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late PublicProfilePage page;
  late PublicProfileInitialParams initParams;
  late PublicProfilePresentationModel model;
  late PublicProfilePresenter presenter;
  late PublicProfileNavigator navigator;
  late GetUserUseCase getUserUseCase;
  late GetCollectionsUseCase getCollectionsUseCase;
  late GetUserCirclesUseCase getUserCirclesUseCase;
  late BlockUserUseCase blockUserUseCase;
  late GetProfileStatsUseCase getProfileStatsUseCase;

  const userId = Id.empty();

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initParams = const PublicProfileInitialParams(userId: userId);
    model = PublicProfilePresentationModel.initial(
      initParams,
      Mocks.userStore,
      Mocks.featureFlagsStore,
    );
    navigator = PublicProfileNavigator(Mocks.appNavigator);
    getUserUseCase = GetUserUseCase(Mocks.usersRepository);
    getCollectionsUseCase = GetCollectionsUseCase(Mocks.collectionsRepository);
    getUserCirclesUseCase = GetUserCirclesUseCase(Mocks.circlesRepository);
    getProfileStatsUseCase = GetProfileStatsUseCase(Mocks.usersRepository);
    blockUserUseCase = BlockUserUseCase(Mocks.usersRepository);

    when(() => Mocks.usersRepository.getUser(userId: userId))
        .thenAnswer((invocation) => successFuture(Stubs.publicProfile));
    when(() => ProfileMocks.savedPostsRepository.getSavedPosts(nextPageCursor: any(named: "nextPageCursor")))
        .thenAnswer(
      (invocation) => successFuture(PaginatedList(pageInfo: const PageInfo.empty(), items: [Stubs.imagePost])),
    );
    when(() => Mocks.circlesRepository.getCircles())
        .thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
    when(
      () => Mocks.circlesRepository.getUserCircles(
        nextPageCursor: any(named: 'nextPageCursor'),
        roles: any(named: 'roles'),
        userId: any(named: 'userId'),
        searchQuery: any(named: 'searchQuery'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(() => Mocks.usersRepository.followUnFollowUser(userId: userId, follow: true))
        .thenAnswer((invocation) => successFuture(unit));

    when(() => Mocks.usersRepository.getProfileStats(userId: userId))
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
    when(() => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")))
        .thenAnswer((_) => successFuture(Stubs.basicChat));
    when(
      () => Mocks.followUserUseCase.execute(
        userId: Stubs.user.id,
        follow: true,
      ),
    ).thenAnswer((invocation) => successFuture(unit));
    presenter = PublicProfilePresenter(
      model,
      navigator,
      getUserUseCase,
      getCollectionsUseCase,
      getUserCirclesUseCase,
      blockUserUseCase,
      Mocks.unblockUserUseCase,
      Mocks.followUserUseCase,
      ProfileMocks.getUserPostsUseCase,
      const GetUserActionUseCase(),
      Mocks.sendGlitterBombUseCase,
      ChatMocks.createSingleChatUseCase,
      getProfileStatsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.clipboardManager,
    );
    page = PublicProfilePage(presenter: presenter);
  }

  await screenshotTest(
    "public_profile_page",
    variantName: "collections_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "public_profile_page",
    variantName: "collections_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.collectionsEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    _initMvp();
    final page = getIt<PublicProfilePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
