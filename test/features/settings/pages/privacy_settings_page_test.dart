import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_navigator.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_page.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mocks.dart';

Future<void> main() async {
  late PrivacySettingsPage page;
  late PrivacySettingsInitialParams initParams;
  late PrivacySettingsPresentationModel model;
  late PrivacySettingsPresenter presenter;
  late PrivacySettingsNavigator navigator;

  void _initMvp() {
    initParams = const PrivacySettingsInitialParams();
    model = PrivacySettingsPresentationModel.initial(
      initParams,
    );
    navigator = PrivacySettingsNavigator(Mocks.appNavigator);
    presenter = PrivacySettingsPresenter(
      model,
      navigator,
      SettingsMocks.updatePrivacySettingsUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      SettingsMocks.getPrivacySettingsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    when(() => SettingsMocks.getPrivacySettingsUseCase.execute())
        .thenAnswer((_) => successFuture(Stubs.privacySettings));

    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
        .thenAnswer((_) => successFuture(RuntimePermissionStatus.granted));

    page = PrivacySettingsPage(presenter: presenter);
  }

  await screenshotTest(
    "privacy_settings_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PrivacySettingsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
