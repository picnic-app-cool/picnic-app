import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

mixin SellSeedsSecondStepRoute {
  Future<void> openSellSeedsSecondStep(SellSeedsSecondStepInitialParams initialParams) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<SellSeedsSecondStepPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
