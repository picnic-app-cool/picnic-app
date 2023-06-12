import 'package:flutter/widgets.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class GenderSelectFormNavigator with NoRoutes {
  GenderSelectFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin GenderSelectFormRoute {
  Future<void> openGenderSelectForm(GenderSelectFormInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<GenderSelectFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
