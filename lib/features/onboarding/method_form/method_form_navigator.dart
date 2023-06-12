import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';
import 'package:picnic_app/navigation/url_route.dart';

class MethodFormNavigator with ErrorBottomSheetRoute, UrlRoute {
  MethodFormNavigator(this.appNavigator);

  final AppNavigator appNavigator;
}

mixin MethodFormRoute {
  Future<void> openMethodForm(MethodFormInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<MethodFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
