import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';
import 'package:picnic_app/features/onboarding/splash/splash_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class SplashNavigator with NoRoutes {
  SplashNavigator(this.appNavigator);

  @override
  AppNavigator appNavigator;
}

mixin SplashRoute {
  Future<void> openSplash(
    SplashInitialParams initialParams,
  ) async {
    return appNavigator.pushReplacement(
      splashRoute(getIt<SplashPage>(param1: initialParams)),
      context: context,
    );
  }

  BuildContext? get context;

  AppNavigator get appNavigator;

  Route<T> splashRoute<T>(Widget page) => PageRouteBuilder<T>(
        //ignore: prefer-trailing-comma
        pageBuilder: (_, __, ___) => page,
        opaque: false,
        transitionDuration: Constants.splashTransitionDuration,
        //ignore: prefer-trailing-comma
        transitionsBuilder: _splashTransition,
      );

  Widget _splashTransition(
    BuildContext context,
    Animation<double> anim,
    Animation<double> secondaryAnim,
    Widget child,
  ) {
    return _primaryTransition(
      primaryAnim: anim,
      child: SlidingPageTransition.secondaryTransition(secondaryAnim, child),
    );
  }

  Widget _primaryTransition({
    required Widget child,
    required Animation<double> primaryAnim,
  }) =>
      FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: primaryAnim,
            curve: const Interval(
              0.4,
              1,
              curve: Curves.ease,
            ),
          ),
        ),
        child: child,
      );
}
