import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/profile/domain/model/get_notifications_failure.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late NotificationsListPresentationModel model;
  late NotificationsListPresenter presenter;
  late MockNotificationsNavigator navigator;

  const firstPage = Cursor.firstPage();

  test(
    "onInit should call loading useCases",
    () async {
      presenter.onInit();
    },
  );

  group('get notifications', () {
    Future<Either<GetNotificationsFailure, PaginatedList<ProfileNotification>>> getNotificationsUseCase() {
      return ProfileMocks.getNotificationsUseCase.execute(nextPageCursor: firstPage);
    }

    test('get notifications should return notifications successful', () {
      //GIVEN
      when(
        () => getNotificationsUseCase(),
      ).thenAnswer((_) => successFuture(const PaginatedList.firstPage()));

      //WHEN
      presenter.loadNotifications();

      //THEN
      verify(
        () => getNotificationsUseCase(),
      ).called(1);
    });

    test('get notifications should return a fail and show an error', () {
      //GIVEN
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());
      when(
        () => ProfileMocks.getNotificationsUseCase.execute(nextPageCursor: firstPage),
      ).thenAnswer((_) => failFuture(const GetNotificationsFailure.unknown()));

      //WHEN
      presenter.loadNotifications();

      //THEN
      verify(
        () => getNotificationsUseCase(),
      ).called(1);
    });
  });

  group('on tap toggle follow', () {
    Future<Either<FollowUnfollowUserFailure, Unit>> followUserUseCase({
      required bool follow,
    }) {
      return Mocks.followUserUseCase.execute(
        userId: any(named: "userId"),
        follow: follow,
      );
    }

    Future<Either<JoinCircleFailure, Unit>> joinCircleUseCase() {
      return Mocks.joinCircleUseCase.execute(
        circleId: any(named: "circleId"),
        circle: any(named: "circle"),
      );
    }

    test('tapping toggle follow should unfollow user', () {
      //GIVEN
      when(
        () => followUserUseCase(follow: false),
      ).thenAnswer((_) => successFuture(unit));

      //WHEN
      presenter.onTapToggleFollow(
        userId: Stubs.profileNotificationFollow.userId,
        iFollow: true,
      );

      //THEN
      verify(
        () => followUserUseCase(follow: false),
      ).called(1);
    });

    test('tapping toggle follow should follow user', () {
      //GIVEN
      when(
        () => followUserUseCase(follow: true),
      ).thenAnswer((_) => successFuture(unit));

      //WHEN
      presenter.onTapToggleFollow(
        userId: Stubs.profileNotificationFollow.userId,
        iFollow: false,
      );

      //THEN
      verify(
        () => followUserUseCase(follow: true),
      ).called(1);
    });

    test(
      'tapping join should join circle',
      () {
        //GIVEN
        when(
          () => joinCircleUseCase(),
        ).thenAnswer((_) => successFuture(unit));

        //WHEN
        presenter.onTapJoin(
          Stubs.id,
        );

        //THEN
        verify(
          () => joinCircleUseCase(),
        ).called(1);
      },
    );
  });

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
      Stubs.featureFlags.enable(FeatureFlagType.showPostRemovedBottomSheet),
    );
    model = NotificationsListPresentationModel.initial(
      const NotificationsListInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockNotificationsNavigator();

    when(
      () => ProfileMocks.getNotificationsUseCase.execute(nextPageCursor: firstPage),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList.singlePage([
          Stubs.profileNotificationGlitterbomb,
          Stubs.profileNotificationFollow,
        ]),
      ),
    );

    presenter = NotificationsListPresenter(
      model,
      navigator,
      ProfileMocks.getNotificationsUseCase,
      Mocks.followUserUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.addDeeplinkUseCase,
      Mocks.joinCircleUseCase,
    );
  });
}
