import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class CodeVerificationFormNavigator with NoRoutes, ErrorBottomSheetRoute {
  CodeVerificationFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CodeVerificationFormRoute {
  Future<void> openCodeVerificationForm(CodeVerificationFormInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<CodeVerificationFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
