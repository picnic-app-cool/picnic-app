import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class PermissionsFormNavigator with CloseRoute, ErrorBottomSheetRoute {
  PermissionsFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PermissionsFormRoute {
  Future<void> openPermissionsForm(PermissionsFormInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<PermissionsFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
