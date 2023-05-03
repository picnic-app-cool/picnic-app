import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class SavedPostsNavigator with ErrorBottomSheetRoute, PostDetailsRoute {
  SavedPostsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SavedPostsRoute {
  Future<void> openSavedPosts(SavedPostsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SavedPostsPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
