import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_navigator.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_page.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../create_circle/mocks/create_circle_mocks.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late CircleConfigPage page;
  late CircleConfigInitialParams initParams;
  late CircleConfigPresentationModel model;
  late CircleConfigPresenter presenter;
  late CircleConfigNavigator navigator;

  void initMvp() {
    when(() => CirclesMocks.getDefaultCircleConfigUseCase.execute()).thenAnswer(
      (_) => successFuture(Stubs.circleConfig),
    );
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = const CircleConfigInitialParams(isNewCircle: true);
    model = CircleConfigPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = CircleConfigNavigator(Mocks.appNavigator);
    presenter = CircleConfigPresenter(
      model,
      navigator,
      CirclesMocks.getDefaultCircleConfigUseCase,
      CreateCircleMocks.createCircleUseCase,
      Mocks.updateCircleUseCase,
    );
    page = CircleConfigPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_config_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<CircleConfigPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
