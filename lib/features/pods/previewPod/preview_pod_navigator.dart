import 'package:picnic_app/features/circles/pods/pod_web_view_navigator.dart';
import 'package:picnic_app/features/pods/enable_pod_success_bottom_sheet_route.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_initial_params.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class PreviewPodNavigator with NoRoutes, ErrorBottomSheetRoute, PodWebViewRoute, EnablePodSuccessBottomSheetRoute {
  PreviewPodNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PreviewPodRoute {
  Future<void> openPreviewPod(PreviewPodInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(PreviewPodPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
