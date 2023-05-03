import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_page.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late CircleSettingsPage page;
  late CircleSettingsInitialParams initParams;
  late CircleSettingsPresentationModel model;
  late CircleSettingsPresenter presenter;
  late CircleSettingsNavigator navigator;

  void _initMvp({
    int unresolvedReportsCount = 0,
    bool customRolesEnabled = false,
    bool isCircleConfigEnabled = false,
    bool isCirclePrivacyDiscoverableEnabled = false,
  }) {
    when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: any(named: 'circleId'))).thenAnswer((_) {
      return successFuture(Stubs.circle);
    });
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    when(() => Mocks.currentTimeProvider.currentTime).thenAnswer((_) => DateTime(2022, 8, 20));
    var featureFlags = Stubs.featureFlags;
    if (customRolesEnabled) {
      featureFlags = featureFlags.enable(FeatureFlagType.customRoles);
    } else {
      featureFlags = featureFlags.disable(FeatureFlagType.customRoles);
    }
    if (isCircleConfigEnabled) {
      featureFlags = featureFlags.enable(FeatureFlagType.circleConfig);
    } else {
      featureFlags = featureFlags.disable(FeatureFlagType.circleConfig);
    }
    if (isCirclePrivacyDiscoverableEnabled) {
      featureFlags = featureFlags.enable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled);
    } else {
      featureFlags = featureFlags.disable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled);
    }
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => featureFlags);
    initParams = CircleSettingsInitialParams(
      circleRole: CircleRole.director,
      circle: Stubs.circle.copyWith(name: '#roblox', reportsCount: unresolvedReportsCount),
    );
    model = CircleSettingsPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.currentTimeProvider,
    );
    navigator = CircleSettingsNavigator(Mocks.appNavigator, Mocks.userStore);

    presenter = CircleSettingsPresenter(
      model,
      navigator,
      Mocks.clipboardManager,
      CirclesMocks.getCircleDetailsUseCase,
    );
    page = CircleSettingsPage(presenter: presenter);
    when(() => Mocks.currentTimeProvider.currentTime).thenAnswer((invocation) => DateTime(2022, 8, 26));
  }

  await screenshotTest(
    "circle_settings_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_settings_page_with_custom_roles_enabled",
    setUp: () async {
      _initMvp(customRolesEnabled: true);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_settings_page_with_circle_config_enabled",
    setUp: () async {
      _initMvp(isCircleConfigEnabled: true);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_settings_page_with_privacy_discoverability_enabled",
    setUp: () async {
      _initMvp(isCirclePrivacyDiscoverableEnabled: true);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CircleSettingsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
