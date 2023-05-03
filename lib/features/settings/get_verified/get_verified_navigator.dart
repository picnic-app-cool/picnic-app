import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_navigator.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class GetVerifiedNavigator with WebViewRoute, CloseRoute, CommunityGuidelinesRoute {
  GetVerifiedNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin GetVerifiedRoute {
  void openGetVerified(GetVerifiedInitialParams initialParams) => appNavigator.push(
        materialRoute(getIt<GetVerifiedPage>(param1: initialParams)),
      );

  AppNavigator get appNavigator;
}
