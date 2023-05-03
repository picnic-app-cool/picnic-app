import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/link_post/link_post_initial_params.dart';
import 'package:picnic_app/features/posts/link_post/link_post_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class LinkPostNavigator with WebViewRoute, CloseWithResultRoute<PostRouteResult>, ErrorBottomSheetRoute {
  LinkPostNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin LinkPostRoute {
  Future<PostRouteResult?> openLinkPost(LinkPostInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<LinkPostPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
