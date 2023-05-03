import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_initial_params.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_navigator.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_page.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presentation_model.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late LoadingSplashPage page;
  late LoadingSplashInitialParams initParams;
  late LoadingSplashPresentationModel model;
  late LoadingSplashPresenter presenter;
  late LoadingSplashNavigator navigator;

  void initMvp() {
    initParams = const LoadingSplashInitialParams();
    model = LoadingSplashPresentationModel.initial(
      initParams,
    );
    navigator = LoadingSplashNavigator(Mocks.appNavigator);
    presenter = LoadingSplashPresenter(
      model,
      navigator,
    );
    page = LoadingSplashPage(presenter: presenter);
  }

  await screenshotTest(
    "loading_splash_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<LoadingSplashPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
