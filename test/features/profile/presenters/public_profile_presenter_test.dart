import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/public_profile_tab.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late PublicProfilePresentationModel model;
  late PublicProfilePresenter presenter;
  late MockPublicProfileNavigator navigator;
  late Id userId;

  test(
    'pressing back should close current screen with true as a reasult',
    () {
      // WHEN
      presenter.onTapBack();

      // THEN
      verify(() => navigator.closeWithResult(true));
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
    'tapping on more should show PicnicHorizontalActionBottomSheet',
    () {
      // WHEN
      presenter.onTapMore();

      // THEN
      verify(
        () => navigator.showHorizontalActionBottomSheet(
          actions: any(named: 'actions'),
          onTapClose: any(named: 'onTapClose'),
        ),
      );
    },
  );

  test(
    'tapping on report should open ReportFormPage',
    () {
      // WHEN
      presenter.onTapReport();

      // THEN
      verify(
        () => navigator.openReportForm(any()),
      );
    },
  );

  test(
    'tapping on share profile should close screen and open share dialog',
    () {
      // WHEN
      presenter.onTapShareProfile();

      // THEN
      verify(() => navigator.close());
      verify(() => navigator.shareText(text: any(named: 'text')));
    },
  );

  test(
    'tapping on share circle link should open share dialog',
    () {
      // GIVEN
      const circleLink = 'https://share.link/circle';

      // WHEN
      presenter.onTapShareCircleLink(circleLink);

      // THEN
      verify(
        () => navigator.shareText(text: circleLink),
      );
    },
  );

  test(
    'tapping on enter circle should open CircleDetailsPage',
    () {
      // WHEN
      presenter.onTapEnterCircle(Stubs.id);

      // THEN
      verify(
        () => navigator.openCircleDetails(any()),
      );
    },
  );

  test(
    'tapping on pos should open SingleFeedPage',
    () {
      // WHEN
      presenter.onTapViewPost(Stubs.pollPost);

      // THEN
      verify(
        () => navigator.openSingleFeed(any()),
      );
    },
  );

  test(
    'tapping on collection should open CollectionPage',
    () {
      // WHEN
      presenter.onTapCollection(Stubs.collection);

      // THEN
      verify(
        () => navigator.openCollection(any()),
      );
    },
  );

  test(
    'tapping on open link should open web view',
    () {
      // GIVEN
      const link = 'https://open.that/link';

      // WHEN
      presenter.openLink(link);

      // THEN
      verify(
        () => navigator.openWebView(link),
      );
    },
  );

  test(
    'tapping on username should copy the text and show a snackbar',
    () async {
      // GIVEN
      when(
        () => Mocks.clipboardManager.saveText(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );
      when(
        () => navigator.showSnackBar(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      await presenter.onTapCopyUserName();

      // THEN
      verify(() => Mocks.clipboardManager.saveText(any()));
      verify(() => navigator.showSnackBar(any()));
    },
  );

  test(
    'tapping on report should open ReportFormPage',
    () {
      // WHEN
      presenter.onTapReport();

      // THEN
      verify(
        () => navigator.openReportForm(any()),
      );
    },
  );

  test(
    'tapping on folowers should open FollowersPage',
    () {
      // WHEN
      presenter.onTapStat(StatType.followers);

      // THEN
      verify(() => navigator.openFollowers(any()));
    },
  );

  test(
    'tapping on tab should change current tab to selected one',
    () {
      // GIVEN
      const selectedTab = 1;

      // WHEN
      presenter.onTabChanged(selectedTab);

      // THEN
      expect(presenter.state.selectedTab, PublicProfileTab.circles);
    },
  );

  test(
    "onInit should call loading useCases",
    () async {
      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => Mocks.getUserUseCase.execute(userId: model.publicProfile.user.id));
      verify(() => ProfileMocks.getProfileStatsUseCase.execute(userId: model.publicProfile.user.id));
    },
  );

  test(
    'tapping on dm should open SingleChatPage',
    () async {
      fakeAsync((async) {
        // GIVEN

        when(() => navigator.openSingleChat(any())).thenAnswer((invocation) {
          return Future.value();
        });

        // WHEN
        presenter.onInit();
        presenter.onTapDm();
        async.flushMicrotasks();

        // THEN
        verify(() => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")));
        verify(() => navigator.openSingleChat(any()));
      });
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    userId = const Id.empty();

    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = PublicProfilePresentationModel.initial(
      PublicProfileInitialParams(userId: userId),
      Mocks.userStore,
      Mocks.featureFlagsStore,
    );
    navigator = MockPublicProfileNavigator();

    when(() => Mocks.getUserUseCase.execute(userId: userId))
        .thenAnswer((invocation) => successFuture(const PublicProfile.empty()));

    when(() => ProfileMocks.getProfileStatsUseCase.execute(userId: userId))
        .thenAnswer((invocation) => successFuture(Stubs.profileStats));

    when(
      () => Mocks.getCollectionsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
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

    when(
      () => Mocks.blockUserUseCase.execute(
        userId: Stubs.user.id,
      ),
    ).thenAnswer((invocation) => successFuture(unit));

    when(() => Mocks.followUserUseCase.execute(userId: Stubs.user.id, follow: true))
        .thenAnswer((invocation) => successFuture(unit));

    when(() => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")))
        .thenAnswer((_) => successFuture(Stubs.basicChat));

    presenter = PublicProfilePresenter(
      model,
      navigator,
      Mocks.getUserUseCase,
      Mocks.getCollectionsUseCase,
      Mocks.getUserCirclesUseCase,
      Mocks.blockUserUseCase,
      Mocks.unblockUserUseCase,
      Mocks.followUserUseCase,
      ProfileMocks.getUserPostsUseCase,
      const GetUserActionUseCase(),
      Mocks.sendGlitterBombUseCase,
      ChatMocks.createSingleChatUseCase,
      ProfileMocks.getProfileStatsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.clipboardManager,
    );

    when(() => navigator.openFollowers(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openReportForm(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.shareText(text: any(named: 'text'))).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openCircleDetails(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openCircleDetails(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openSingleFeed(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openCollection(any())).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openWebView(any())).thenAnswer((invocation) {
      return Future.value();
    });
  });
}
