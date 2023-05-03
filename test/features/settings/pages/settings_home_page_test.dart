import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_navigator.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_page.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presentation_model.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late SettingsHomePage page;
  late SettingsHomeInitialParams initParams;
  late SettingsHomePresentationModel model;
  late SettingsHomePresenter presenter;
  late SettingsHomeNavigator navigator;

  void _initMvp() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    initParams = SettingsHomeInitialParams(user: Stubs.user);
    model = SettingsHomePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = SettingsHomeNavigator(Mocks.appNavigator);

    presenter = SettingsHomePresenter(
      model,
      navigator,
      Mocks.logOutUseCase,
      Mocks.appInfoStore,
      Mocks.copyTextUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    page = SettingsHomePage(presenter: presenter);
  }

  await screenshotTest(
    "settings_home_page",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags,
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    _initMvp();
    final page = getIt<SettingsHomePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
