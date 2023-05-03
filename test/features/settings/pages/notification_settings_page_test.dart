import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_navigator.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_page.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mocks.dart';

Future<void> main() async {
  late NotificationSettingsPage page;
  late NotificationSettingsInitialParams initParams;
  late NotificationSettingsPresentationModel model;
  late NotificationSettingsPresenter presenter;
  late NotificationSettingsNavigator navigator;

  void _initMvp() {
    initParams = const NotificationSettingsInitialParams();
    model = NotificationSettingsPresentationModel.initial(
      initParams,
    );
    navigator = NotificationSettingsNavigator(Mocks.appNavigator);
    presenter = NotificationSettingsPresenter(
      model,
      navigator,
      SettingsMocks.getNotificationSettingsUseCase,
      SettingsMocks.updateNotificationSettingsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    when(() => SettingsMocks.getNotificationSettingsUseCase.execute())
        .thenAnswer((_) => successFuture(Stubs.notificationSettings));

    when(
      () => SettingsMocks.updateNotificationSettingsUseCase.execute(
        notificationSettings: const NotificationSettings.empty(),
      ),
    ).thenAnswer(
      (_) => successFuture(unit),
    );
    page = NotificationSettingsPage(presenter: presenter);
  }

  await screenshotTest(
    "notification_settings_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<NotificationSettingsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
