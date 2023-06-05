import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';

class PodsCategoriesNavigator with AddCirclePodRoute, ErrorBottomSheetRoute, ShareRoute {
  PodsCategoriesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PodsCategoriesRoute {
  Future<void> openPodsCategories(PodsCategoriesInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(PodsCategoriesPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
