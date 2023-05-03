import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class CongratsFormNavigator with NoRoutes {
  CongratsFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CongratsFormRoute {
  Future<void> openCongratsForm(CongratsFormInitialParams initialParams) async {
    return appNavigator.pushAndRemoveUntilRoot(
      SlidingPageTransition(getIt<CongratsFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
