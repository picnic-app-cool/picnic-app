import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';
import 'package:picnic_app/navigation/url_route.dart';

class PhoneFormNavigator with ErrorBottomSheetRoute, UrlRoute {
  PhoneFormNavigator(this.appNavigator);

  final AppNavigator appNavigator;
}

mixin PhoneFormRoute {
  Future<void> openPhoneForm(PhoneFormInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<PhoneFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
