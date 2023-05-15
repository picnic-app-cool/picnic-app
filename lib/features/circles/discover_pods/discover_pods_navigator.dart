import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_page.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class DiscoverPodsNavigator with ErrorBottomSheetRoute, PodWebViewRoute {
  DiscoverPodsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin DiscoverPodsRoute {
  Future<void> openDiscoverPods(DiscoverPodsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(DiscoverPodsPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
