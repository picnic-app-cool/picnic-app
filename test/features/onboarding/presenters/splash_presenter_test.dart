import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presenter.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late SplashPresentationModel model;
  late SplashPresenter presenter;
  late MockSplashNavigator navigator;

  test(
    "'getStarted' tap should call callback",
    () {
      // GIVEN
      var onTapCalled = false;
      when(() => model.onTapGetStartedCallback).thenReturn(() => onTapCalled = true);

      // WHEN
      presenter.onTapGetStarted();

      // THEN
      expect(onTapCalled, isTrue);
    },
  );

  test(
    "'login' tap should call callback",
    () {
      // GIVEN
      var onTapCalled = false;
      when(() => model.onTapLoginCallback).thenReturn(() => onTapCalled = true);

      // WHEN
      presenter.onTapLogin();

      // THEN
      expect(onTapCalled, isTrue);
    },
  );

  setUp(() {
    model = MockSplashPresentationModel();
    navigator = MockSplashNavigator();
    presenter = SplashPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
