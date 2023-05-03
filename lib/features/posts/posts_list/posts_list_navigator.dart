import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_page.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class PostsListNavigator with PublicProfileRoute, PrivateProfileRoute, ReportFormRoute, PostCreationIndexRoute {
  PostsListNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PostsListRoute {
  Future<void> openPostsList(PostsListInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PostsListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
