import 'package:flutter/material.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_page.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/background_calls_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

//ignore_for_file: unused-code
class PostUploadingProgressNavigator with NoRoutes, BackgroundCallsRoute, AfterPostModalRoute {
  PostUploadingProgressNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  BuildContext get context => AppNavigator.currentContext;
}

mixin PostUploadingProgressRoute {
  Future<void> openPostUploadingProgress(PostUploadingProgressInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(PostUploadingProgressPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
