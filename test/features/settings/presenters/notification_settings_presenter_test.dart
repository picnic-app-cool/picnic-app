import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presenter.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mock_definitions.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late NotificationSettingsPresentationModel model;
  late NotificationSettingsPresenter presenter;
  late MockNotificationSettingsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = NotificationSettingsPresentationModel.initial(const NotificationSettingsInitialParams());
    navigator = MockNotificationSettingsNavigator();
    presenter = NotificationSettingsPresenter(
      model,
      navigator,
      SettingsMocks.getNotificationSettingsUseCase,
      SettingsMocks.updateNotificationSettingsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
