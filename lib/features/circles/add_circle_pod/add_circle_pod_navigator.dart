import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_page.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class AddCirclePodNavigator with ErrorBottomSheetRoute, DiscoverPodsRoute {
  AddCirclePodNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AddCirclePodRoute {
  Future<void> openAddCirclePod(AddCirclePodInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(AddCirclePodPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
