import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_page.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presenter.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../posts/mocks/posts_mocks.dart';
import '../../seeds/mocks/seeds_mocks.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleDetailsPage page;
  late CircleDetailsInitialParams initParams;
  late CircleDetailsPresentationModel model;
  late CircleDetailsPresenter presenter;
  late CircleDetailsNavigator navigator;

  void _initMvp() {
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(
      () => CirclesMocks.getLastUsedSortingOptionUseCase.execute(
        circleId: any(named: 'circleId'),
      ),
    ).thenAnswer((_) => successFuture(Stubs.trendingThisWeekPostsSortingType));

    when(
      () => CirclesMocks.viewCircleUseCase.execute(
        circleId: any(named: 'circleId'),
      ),
    ).thenAnswer((_) => successFuture(unit));
    initParams = CircleDetailsInitialParams(
      circleId: Stubs.id,
    );
    model = CircleDetailsPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
    when(
      () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
        circleId: any(named: 'circleId'),
        cursor: any(named: 'cursor'),
        roles: any(named: 'roles'),
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage([Stubs.circleMemberDirector, Stubs.circleMemberDirector])),
    );

    navigator = CircleDetailsNavigator(Mocks.appNavigator, Mocks.userStore);

    presenter = CircleDetailsPresenter(
      model,
      navigator,
      CirclesMocks.getRoyaltyUseCase,
      Mocks.joinCircleUseCase,
      Mocks.leaveCircleUseCase,
      CirclesMocks.getCircleDetailsUseCase,
      Mocks.getCircleStatsUseCase,
      ChatMocks.getChatUseCase,
      Mocks.getSlicesUseCase,
      Mocks.clipboardManager,
      Mocks.joinSliceUseCase,
      CirclesMocks.getCircleSortedPostsUseCase,
      Mocks.deletePostsUseCase,
      SeedsMocks.getSeedholdersUseCase,
      SeedsMocks.getGovernanceUseCase,
      CirclesMocks.getLastUsedSortingOptionUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.sharePostUseCase,
      PostsMocks.likeUnlikePostUseCase,
      Mocks.savePostToCollectionUseCase,
      PostsMocks.getPostUseCase,
      Mocks.followUserUseCase,
      CirclesMocks.getCircleMembersByRoleUseCase,
      PostsMocks.unreactToPostUseCase,
      CirclesMocks.viewCircleUseCase,
    );

    when(
      () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
        circleId: model.circle.id,
        cursor: model.posts.nextPageCursor(),
        roles: [
          CircleRole.director,
        ],
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.empty(),
          items: [
            Stubs.circleMemberDirector,
            Stubs.circleMemberDirector,
          ],
        ),
      ),
    );
    when(
      () => CirclesMocks.getRoyaltyUseCase.execute(),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.empty(),
          items: [Stubs.royalty.copyWith(points: 20), Stubs.royalty.copyWith(points: 30)],
        ),
      ),
    );

    when(() => Mocks.joinCircleUseCase.execute(circle: Stubs.basicCircle)).thenAnswer((_) => successFuture(unit));

    when(() => Mocks.leaveCircleUseCase.execute(circle: Stubs.basicCircle)).thenAnswer((_) => successFuture(unit));
    when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id)).thenAnswer((_) {
      return successFuture(Stubs.circle);
    });
    when(() => Mocks.getCircleStatsUseCase.execute(circleId: Stubs.id)) //
        .thenSuccess((_) => Stubs.circleStats);

    when(() => SeedsMocks.getGovernanceUseCase.execute(circleId: Stubs.id)) //
        .thenSuccess((_) => Stubs.election);

    when(
      () => CirclesMocks.getCircleSortedPostsUseCase.execute(
        circleId: model.circle.id,
        nextPageCursor: model.posts.nextPageCursor(),
        sortingType: model.postSortOption,
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.posts),
    );
    when(() => SeedsMocks.getSeedholdersUseCase.execute(circleId: Stubs.id)).thenAnswer((_) {
      return successFuture(PaginatedList.singlePage(List.filled(5, Stubs.seedHolder)));
    });
    when(
      () => Mocks.circlePostsRepository.getLastUsedSortingOption(
        circleId: Stubs.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.trendingThisWeekPostsSortingType),
    );
    page = CircleDetailsPage(presenter: presenter);
  }

  screenshotTest(
    "circle_details_view_page",
    variantName: "royalty_tab_enabled",
    setUp: () async {
      _initMvp();

      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      when(
        () => CirclesMocks.getCircleSortedPostsUseCase.execute(
          circleId: any(named: 'circleId'),
          nextPageCursor: any(named: 'nextPageCursor'),
          sortingType: model.postSortOption,
        ),
      ).thenAnswer(
        (invocation) => successFuture(Stubs.posts),
      );
      when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
      when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id))
          .thenAnswer((_) => successFuture(Stubs.circle.copyWith(iJoined: true)));
      when(
        () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
          circleId: any(named: 'circleId'),
          cursor: any(named: 'cursor'),
          roles: any(named: 'roles'),
        ),
      ).thenAnswer((_) => successFuture(const PaginatedList.firstPage()));
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "royalty_tab_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.royaltyTabEnabled),
      );
      _initMvp();
      when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id))
          .thenAnswer((_) => successFuture(Stubs.circle.copyWith(iJoined: true)));
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "circle_verified",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      _initMvp();
      when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id))
          .thenAnswer((_) => successFuture(Stubs.circle.copyWith(isVerified: true, iJoined: true)));
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "circle_unverified",
    setUp: () async {
      when(
        () => CirclesMocks.getCircleSortedPostsUseCase.execute(
          circleId: model.circle.id,
          nextPageCursor: model.posts.nextPageCursor(),
          sortingType: model.postSortOption,
        ),
      ).thenAnswer(
        (invocation) => successFuture(Stubs.posts),
      );
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags,
      );
      _initMvp();
      when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id))
          .thenAnswer((_) => successFuture(Stubs.circle.copyWith(iJoined: true)));
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "slices_tab_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      when(
        () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
          circleId: any(named: 'circleId'),
          cursor: any(named: 'cursor'),
          roles: any(named: 'roles'),
        ),
      ).thenAnswer((_) => successFuture(const PaginatedList.firstPage()));
      _initMvp();
    },
    pageBuilder: () => page,
  );
  screenshotTest(
    "circle_details_view_page",
    variantName: "slices_tab_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      when(
        () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
          circleId: any(named: 'circleId'),
          cursor: any(named: 'cursor'),
          roles: any(named: 'roles'),
        ),
      ).thenAnswer((_) => successFuture(const PaginatedList.firstPage()));
      _initMvp();
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "circle_discoverability_private_and_user_not_joined",
    setUp: () async {
      _initMvp();
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
      when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id)).thenAnswer(
        (_) => successFuture(
          Stubs.circle.copyWith(visibility: CircleVisibility.private, iJoined: false),
        ),
      );
      when(
        () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
          circleId: any(named: 'circleId'),
          cursor: any(named: 'cursor'),
          roles: any(named: 'roles'),
        ),
      ).thenAnswer((_) => successFuture(const PaginatedList.firstPage()));
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "slices_tab_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.slicesEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "circle_details_view_page",
    variantName: "posting_disabled",
    setUp: () async {
      _initMvp();
      when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.id))
          .thenAnswer((_) => successFuture(Stubs.circleWithPostingDisabled.copyWith(iJoined: true)));
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    final page = getIt<CircleDetailsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
