import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';
import 'package:picnic_app/features/posts/text_post/text_post_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class TextPostNavigator with CloseWithResultRoute<PostRouteResult>, ErrorBottomSheetRoute {
  TextPostNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  late BuildContext context;
}

mixin TextPostRoute {
  Future<PostRouteResult?> openTextPost(TextPostInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<TextPostPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
