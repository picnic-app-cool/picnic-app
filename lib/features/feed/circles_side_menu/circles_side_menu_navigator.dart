import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';

class CirclesSideMenuNavigator
    with ErrorBottomSheetRoute, CircleDetailsRoute, CreateCircleRoute, DiscoverExploreRoute, ShareRoute {
  CirclesSideMenuNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CirclesSideMenuRoute {
  AppNavigator get appNavigator;
}
