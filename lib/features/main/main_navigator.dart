import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/main/main_page.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/background_calls_route.dart';

class MainNavigator with PostCreationIndexRoute, BackgroundCallsRoute {
  MainNavigator(this.appNavigator);

  static const routeName = "main";

  @override
  final AppNavigator appNavigator;

  @override
  BuildContext get context => AppNavigator.currentContext;
}

mixin MainRoute {
  static const animationDuration = 1000;
  static const animationDelayPercentage = 0.8;

  Future<void> openMain(MainInitialParams initialParams) async {
    return appNavigator.pushAndRemoveUntilRoot(
      fadeInWithDelayRoute(
        getIt<MainPage>(param1: initialParams),
        pageName: MainNavigator.routeName,
        durationMillis: animationDuration,
        animationDelayPercent: animationDelayPercentage,
      ),
    );
  }

  void closeUntilMain() {
    appNavigator.popUntilPageWithName(MainNavigator.routeName);
  }

  AppNavigator get appNavigator;
}
