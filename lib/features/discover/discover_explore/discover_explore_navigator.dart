import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_navigator.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_page.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_navigator.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';

class DiscoverExploreNavigator
    with
        DiscoverSearchResultsRoute,
        PublicProfileRoute,
        CircleDetailsRoute,
        ProfileRoute,
        SingleFeedRoute,
        PodWebViewRoute,
        ErrorBottomSheetRoute,
        AddCirclePodRoute,
        DiscoverPodsRoute,
        DiscoverCirclesRoute,
        CircleChatRoute,
        ShareRoute,
        PodBottomSheetRoute {
  DiscoverExploreNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin DiscoverExploreRoute {
  Future<void> openDiscoverExplore(DiscoverExploreInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<DiscoverExplorePage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
