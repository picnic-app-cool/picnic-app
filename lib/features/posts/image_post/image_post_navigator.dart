import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';

class ImagePostNavigator with CloseWithResultRoute<PostRouteResult>, FullScreenImagePostRoute {
  ImagePostNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ImagePostRoute {
  Future<PostRouteResult?> openImagePost(ImagePostInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<ImagePostPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
