import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mock_definitions.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late PrivacySettingsPresentationModel model;
  late PrivacySettingsPresenter presenter;
  late MockPrivacySettingsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  test(
    'tapping show allow access contact should open correctly the bottom sheet dialog',
    () {
      // GIVEN
      when(
        () => navigator.showAllowAccessContactConfirmation(
          onTakeToSettings: any(named: 'onTakeToSettings'),
          onClose: any(named: 'onClose'),
        ),
      ).thenAnswer((_) => Future.value(true));

      // WHEN
      presenter.onTapToggleAccessListContacts(selected: true);

      // THEN
      verify(
        () => navigator.showAllowAccessContactConfirmation(
          onTakeToSettings: any(named: 'onTakeToSettings'),
          onClose: any(named: 'onClose'),
        ),
      ).called(1);
    },
  );

  setUp(() {
    model = PrivacySettingsPresentationModel.initial(const PrivacySettingsInitialParams());
    navigator = MockPrivacySettingsNavigator();
    presenter = PrivacySettingsPresenter(
      model,
      navigator,
      SettingsMocks.updatePrivacySettingsUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      SettingsMocks.getPrivacySettingsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
