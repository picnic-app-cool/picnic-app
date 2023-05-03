import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

import '../../mocks/mocks.dart';

void main() {
  late _NavigatorWithOnBoardingRoute navigator;

  setUp(() {
    navigator = _NavigatorWithOnBoardingRoute(Mocks.appNavigator);
    when(() => Mocks.appNavigator.pushReplacement<void>(any())).thenAnswer((invocation) => Future.value());
  });

  test('verify that subsequent calls to open onBoarding use a different instance of the navigator', () async {
    const initialParams = OnboardingInitialParams();
    await navigator.openOnboarding(initialParams);
    final onBoardingNavigator = getIt.get<OnboardingNavigatorKey>();
    await navigator.openOnboarding(initialParams);
    final onBoardingNavigator2 = getIt.get<OnboardingNavigatorKey>();
    expect(onBoardingNavigator, isNot(equals(onBoardingNavigator2)));
  });
}

class _NavigatorWithOnBoardingRoute with OnboardingRoute {
  @override
  final AppNavigator appNavigator;

  _NavigatorWithOnBoardingRoute(this.appNavigator);
}
