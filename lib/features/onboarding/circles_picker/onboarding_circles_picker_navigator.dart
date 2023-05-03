import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class OnBoardingCirclesPickerNavigator {
  OnBoardingCirclesPickerNavigator();

  late BuildContext context;
}

mixin OnBoardingCirclesPickerRoute {
  Future<void> openOnBoardingCirclesPickerPage(OnBoardingCirclesPickerInitialParams initialParams) async {
    return appNavigator.pushAndRemoveUntilRoot(
      materialRoute(getIt<OnboardingCirclesPickerPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
