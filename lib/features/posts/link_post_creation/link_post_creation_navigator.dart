import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_page.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_toast_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class LinkPostCreationNavigator
    with
        WebViewRoute,
        CircleCreationRulesRoute,
        CreateCircleRoute,
        ErrorBottomSheetRoute,
        ErrorToastRoute,
        SelectCircleRoute {
  LinkPostCreationNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin LinkPostCreationRoute {
  Future<void> openLinkPostCreation(LinkPostCreationInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<LinkPostCreationPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
