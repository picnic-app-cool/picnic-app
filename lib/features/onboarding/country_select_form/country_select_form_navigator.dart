import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class CountrySelectFormNavigator with NoRoutes {
  CountrySelectFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CountrySelectFormRoute {
  Future<void> openCountrySelectForm(
    CountrySelectFormInitialParams initialParams,
  ) async {
    return appNavigator.push(
      SlidingPageTransition(
        getIt<CountrySelectFormPage>(param1: initialParams),
      ),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
