import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_initial_params.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presenter.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/feed_mock_definitions.dart';
import '../mocks/feed_mocks.dart';

void main() {
  late FeedHomePresentationModel model;
  late FeedHomePresenter presenter;
  late MockFeedHomeNavigator navigator;

  test(
    'on tap notification bell and open Notifications list',
    () {
      // GIVEN
      when(
        () => navigator.openNotifications(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapNotifications();

      // THEN
      verify(
        () => navigator.openNotifications(any()),
      );
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    when(() => FeedMocks.localFeedsStore.feeds).thenReturn(Stubs.unmodifiableFeedList);
    when(() => Mocks.userCirclesStore.userCircles).thenReturn(Stubs.basicCircles);
    when(() => FeedMocks.localFeedsStore.stream).thenAnswer((_) => Stubs.feedStream);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    model = FeedHomePresentationModel.initial(
      FeedHomeInitialParams(
        onPostChanged: (post) {},
        onCirclesSideMenuToggled: () {},
      ),
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );
    navigator = MockFeedHomeNavigator();

    when(() => ProfileMocks.getUnreadNotificationsCountUseCase.execute())
        .thenAnswer((invocation) => successFuture(const UnreadNotificationsCount(count: 7)));
    when(() => Mocks.updateAppBadgeCountUseCase.execute(any())).thenAnswer((_) => Future.value());

    presenter = FeedHomePresenter(
      model,
      navigator,
      FeedMocks.getViewPostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      ProfileMocks.getUnreadNotificationsCountUseCase,
      Mocks.updateAppBadgeCountUseCase,
    );
  });
}
