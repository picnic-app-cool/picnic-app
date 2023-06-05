import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_navigator.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_page.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_navigator.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/pods/pods_categories_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class DiscoverPodsNavigator
    with
        DiscoverSearchResultsRoute,
        PublicProfileRoute,
        CircleDetailsRoute,
        ProfileRoute,
        SingleFeedRoute,
        PodWebViewRoute,
        ErrorBottomSheetRoute,
        AddCirclePodRoute,
        PodBottomSheetRoute,
        PodsCategoriesRoute {
  DiscoverPodsNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin DiscoverPodsRoute {
  Future<void> openDiscoverPods(DiscoverPodsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<DiscoverPodsPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
