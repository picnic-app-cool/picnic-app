import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class OnBoardingCirclesPickerNavigator with NoRoutes {
  OnBoardingCirclesPickerNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin OnBoardingCirclesPickerRoute {
  Future<void> openOnBoardingCirclesPickerPage(OnBoardingCirclesPickerInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<OnboardingCirclesPickerPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
