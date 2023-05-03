import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class ChatTabsNavigator with PrivateProfileRoute, DiscoverExploreRoute {
  ChatTabsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
