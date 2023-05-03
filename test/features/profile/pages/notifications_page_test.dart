import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_navigator.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_page.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late NotificationsListPage page;
  late NotificationsListInitialParams initParams;
  late NotificationsListPresentationModel model;
  late NotificationsListPresenter presenter;
  late NotificationsListNavigator navigator;

  void _initMvp() {
    initParams = const NotificationsListInitialParams();
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
      Stubs.featureFlags.disable(FeatureFlagType.showPostRemovedBottomSheet),
    );
    when(() => Mocks.privateProfileRepository.markAllNotificationsAsRead()).thenAnswer(
      (_) => successFuture(unit),
    );
    when(
      () => ProfileMocks.getNotificationsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
        refresh: any(named: 'refresh'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList.singlePage([
          Stubs.profileNotificationGlitterbomb,
          Stubs.profileNotificationFollow,
        ]),
      ),
    );
    model = NotificationsListPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = NotificationsListNavigator(Mocks.appNavigator);
    presenter = NotificationsListPresenter(
      model,
      navigator,
      ProfileMocks.getNotificationsUseCase,
      Mocks.followUserUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.addDeeplinkUseCase,
      Mocks.joinCircleUseCase,
    );
    page = NotificationsListPage(presenter: presenter);
  }

  await screenshotTest(
    "notifications_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    final page = getIt<NotificationsListPage>(param1: MockNotificationsInitialParams());
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
