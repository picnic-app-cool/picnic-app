import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_page.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presentation_model.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presenter.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_form.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late CreateCirclePage page;
  late CreateCircleInitialParams initParams;
  late CreateCirclePresentationModel model;
  late CreateCirclePresenter presenter;
  late CreateCircleNavigator navigator;

  void _initMvp({required CreateCircleForm? form}) {
    initParams = const CreateCircleInitialParams();
    model = CreateCirclePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    ).copyWith(createCircleForm: form ?? Stubs.createCircleForm);
    navigator = CreateCircleNavigator(Mocks.appNavigator);
    presenter = CreateCirclePresenter(
      model,
      navigator,
    );
    page = CreateCirclePage(presenter: presenter);
  }

  await screenshotTest(
    "create_circle_page",
    variantName: "privacy_settings_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled),
      );
      _initMvp(form: Stubs.createCircleForm);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "create_circle_page",
    variantName: "privacy_settings_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled),
      );
      _initMvp(form: Stubs.createCircleForm);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "create_circle_page",
    variantName: "filled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      _initMvp(form: Stubs.createCircleForm);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "create_circle_page",
    variantName: "empty",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      _initMvp(form: const CreateCircleForm.empty());
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    _initMvp(form: const CreateCircleForm.empty());
    final page = getIt<CreateCirclePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
