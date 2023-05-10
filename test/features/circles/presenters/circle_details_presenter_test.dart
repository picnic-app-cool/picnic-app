import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presenter.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_tab.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../posts/mocks/posts_mocks.dart';
import '../../seeds/mocks/seeds_mocks.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleDetailsPresentationModel model;
  late CircleDetailsPresenter presenter;
  late MockCircleDetailsNavigator navigator;

  test(
    'tapping on the user should open the profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.publicProfile.id)).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapViewPublicProfile(Stubs.publicProfile.id);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.publicProfile.id));
    },
  );

  test(
    'initial postSortOption should be set as trendingThisWeek',
    () {
      expect(presenter.state.postSortOption, PostsSortingType.trendingThisWeek);
    },
  );

  test(
    'tapping on the seed holders text should open the seed holders page',
    () {
      //GIVEN
      when(() => navigator.openSeedHolders(any())).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapSeedHolders();

      //THEN
      verify(() => navigator.openSeedHolders(any()));
    },
  );
  test(
    'changing the tab should update the state with the new tab',
    () async {
      //GIVEN

      //WHEN
      presenter.onTabChanged(CircleTab.rules.index);

      //THEN
      expect(presenter.state.selectedTab, CircleTab.rules);
    },
  );

  test(
    'tapping on more should open the bottom sheet',
    () async {
      //GIVEN

      //WHEN
      presenter.onTapMore();

      //THEN
      verify(
        () => navigator.showHorizontalActionBottomSheet(
          actions: any(named: 'actions'),
          onTapClose: any(named: 'onTapClose'),
        ),
      );
    },
  );

  test(
    'tapping settings should call openCircleSettings() from navigator to open Circle Settings',
    () {
      //GIVEN
      when(
        () => navigator.openCircleSettings(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      presenter.onTapSettings();

      //THEN
      verify(
        () => navigator.openCircleSettings(any()),
      ).called(1);
    },
  );
  test(
    'tapping more action should open horizontal bottom sheet',
    () {
      //GIVEN
      when(
        () => navigator.showHorizontalActionBottomSheet(
          actions: any(named: 'actions'),
          onTapClose: any(named: 'onTapClose'),
        ),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapMore();

      //THEN
      verify(
        () => navigator.showHorizontalActionBottomSheet(
          actions: any(named: 'actions'),
          onTapClose: any(named: 'onTapClose'),
        ),
      ).called(1);
    },
  );

  test(
    'tapping on the user should open the profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.publicProfile.id)).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapViewPublicProfile(Stubs.publicProfile.id);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.publicProfile.id));
    },
  );

  test(
    'tapping on add should open CircleRolePage',
    () {
      //GIVEN
      when(() => navigator.openCircleRole(any())).thenAnswer((_) {
        return Future.value();
      });
      // WHEN
      presenter.onTapAddRole();

      // THEN
      verify(
        () => navigator.openCircleRole(any()),
      );
    },
  );

  test(
    'tapping on follow should call followUnfollowUseCase',
    () async {
      await presenter.onLoadMoreMembers();
      // WHEN
      presenter.onTapToggleFollow(Stubs.circleMemberDirector);

      // THEN
      verify(() => Mocks.followUserUseCase.execute(userId: any(named: 'userId'), follow: true));
    },
  );

  test(
    "onLoad should call get members by role useCase",
    () async {
      // WHEN
      await presenter.onLoadMoreMembers();

      // THEN
      verify(
        () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
          circleId: any(named: 'circleId'),
          cursor: any(named: 'cursor'),
          roles: any(named: 'roles'),
        ),
      );
    },
  );

  Circle _getCircleWithPostingConfigs({
    required bool canPostLink,
    required bool canPostPoll,
    required bool canPostPhoto,
    required bool canPostVideo,
    required bool canPostThought,
  }) =>
      Stubs.circle.copyWith(
        configs: [
          const CircleConfig.empty().copyWith(type: CircleConfigType.link, enabled: canPostLink),
          const CircleConfig.empty().copyWith(type: CircleConfigType.poll, enabled: canPostPoll),
          const CircleConfig.empty().copyWith(type: CircleConfigType.photo, enabled: canPostPhoto),
          const CircleConfig.empty().copyWith(type: CircleConfigType.video, enabled: canPostVideo),
          const CircleConfig.empty().copyWith(type: CircleConfigType.text, enabled: canPostThought),
        ],
      );

  final circleWithCanCreatePost = <Circle, bool>{
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: true,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: true,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: true,
      canPostVideo: false,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: true,
      canPostThought: false,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: true,
    ): true,
    _getCircleWithPostingConfigs(
      canPostLink: false,
      canPostPoll: false,
      canPostPhoto: false,
      canPostVideo: false,
      canPostThought: false,
    ): false,
  };

  circleWithCanCreatePost.forEach((circle, canPost) {
    test(
        "expect that based on the circle, the navigation is done correctly to either create post page or to the disabled posting bottom sheet",
        () {
      when(() => navigator.openPostCreation(any())).thenAnswer((_) => Future.value());
      when(
        () => navigator.showDisabledBottomSheet(
          title: any(named: 'title'),
          description: any(named: 'description'),
          onTapClose: any(named: 'onTapClose'),
        ),
      ).thenAnswer((_) => Future.value());

      presenter.emit(model.copyWith(circle: circle));
      presenter.onTapPostToCircle();

      if (canPost) {
        verify(() => navigator.openPostCreation(any()));
      } else {
        verify(
          () => navigator.showDisabledBottomSheet(
            title: any(named: 'title'),
            description: any(named: 'description'),
            onTapClose: any(named: 'onTapClose'),
          ),
        );
      }
    });
  });

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
        circleId: any(named: 'circleId'),
        cursor: any(named: 'cursor'),
        roles: any(named: 'roles'),
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage([Stubs.circleMemberDirector, Stubs.circleMemberDirector])),
    );
    when(
      () => Mocks.followUserUseCase.execute(
        userId: any(named: 'userId'),
        follow: true,
      ),
    ).thenAnswer((_) => successFuture(unit));
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    model = CircleDetailsPresentationModel.initial(
      CircleDetailsInitialParams(circleId: Stubs.circle.id),
      Mocks.featureFlagsStore,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
    navigator = MockCircleDetailsNavigator();
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
      SeedsMocks.getElectionUseCase,
      CirclesMocks.getLastUsedSortingOptionUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.sharePostUseCase,
      PostsMocks.likeUnlikePostUseCase,
      Mocks.savePostToCollectionUseCase,
      PostsMocks.getPostUseCase,
      Mocks.followUserUseCase,
      CirclesMocks.getCircleMembersByRoleUseCase,
      PostsMocks.unreactToPostUseCase,
    );
  });
}
