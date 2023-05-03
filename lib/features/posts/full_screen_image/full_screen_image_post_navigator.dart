import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';

class FullScreenImagePostNavigator with CloseRoute {
  FullScreenImagePostNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin FullScreenImagePostRoute {
  Future<void> openFullScreenImagePost(FullScreenImagePostInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(FullScreenImagePostPage(initialParams: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
