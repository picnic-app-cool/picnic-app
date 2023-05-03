import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_navigator.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_page.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late EditCirclePage page;
  late EditCircleInitialParams initParams;
  late EditCirclePresentationModel model;
  late EditCirclePresenter presenter;
  late EditCircleNavigator navigator;

  void initMvp() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = EditCircleInitialParams(circle: Stubs.circle);
    model = EditCirclePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = EditCircleNavigator(Mocks.appNavigator);
    presenter = EditCirclePresenter(
      model,
      navigator,
      Mocks.updateCircleUseCase,
    );
    page = EditCirclePage(presenter: presenter);
  }

  await screenshotTest(
    "edit_circle_page",
    variantName: "privacy_settings_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled),
      );
      initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "edit_circle_page",
    variantName: "privacy_settings_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled),
      );
      initMvp();
    },
    pageBuilder: () => page,
  );
  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<EditCirclePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
