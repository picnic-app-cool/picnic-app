import 'dart:io';

import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_initial_params.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';

class ChooseMediaNavigator with CloseWithResultRoute<File?> {
  ChooseMediaNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ChooseMediaRoute {
  Future<File?> openChooseMedia(
    ChooseMediaInitialParams initialParams,
  ) async {
    return appNavigator.push(
      materialRoute(getIt<ChooseMediaPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
