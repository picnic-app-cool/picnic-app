import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class PodWebViewNavigator with NoRoutes {
  PodWebViewNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PodWebViewRoute {
  Future<void> openPodWebView(PodWebViewInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(PodWebViewPage(initialParams: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
