import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';
import 'package:picnic_app/features/onboarding/splash/splash_navigator.dart';
import 'package:picnic_app/features/onboarding/splash/splash_page.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late SplashPage page;
  late SplashInitialParams initParams;
  late SplashPresentationModel model;
  late SplashPresenter presenter;
  late SplashNavigator navigator;

  void _initMvp() {
    initParams = SplashInitialParams(onTapLogin: () {}, onTapGetStarted: () {});
    model = SplashPresentationModel.initial(
      initParams,
    );
    navigator = SplashNavigator(Mocks.appNavigator);
    presenter = SplashPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = SplashPage(
      presenter: presenter,
    );
  }

  await screenshotTest(
    "splash_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SplashPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
