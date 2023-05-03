import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_navigator.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_page.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presentation_model.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/debug_mocks.dart';

Future<void> main() async {
  late FeatureFlagsPage page;
  late FeatureFlagsInitialParams initParams;
  late FeatureFlagsPresentationModel model;
  late FeatureFlagsPresenter presenter;
  late FeatureFlagsNavigator navigator;

  void initMvp() {
    whenListen(
      Mocks.featureFlagsStore,
      Stream.fromIterable([Stubs.featureFlags]),
    );
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = const FeatureFlagsInitialParams();
    model = FeatureFlagsPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = FeatureFlagsNavigator(Mocks.appNavigator);
    presenter = FeatureFlagsPresenter(
      model,
      navigator,
      DebugMocks.changeFeatureFlagsUseCase,
      Mocks.getFeatureFlagsUseCase,
      Mocks.featureFlagsStore,
    );
    page = FeatureFlagsPage(presenter: presenter);
  }

  await screenshotTest(
    "feature_flags_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<FeatureFlagsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
