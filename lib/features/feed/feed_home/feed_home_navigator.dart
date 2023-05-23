import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_navigator.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/posts/image_post/image_post_navigator.dart';
import 'package:picnic_app/features/posts/link_post/link_post_navigator.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_navigator.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_navigator.dart';
import 'package:picnic_app/features/posts/text_post/text_post_navigator.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';

class FeedHomeNavigator
    with
        TextPostRoute,
        PollPostRoute,
        LinkPostRoute,
        ImagePostRoute,
        PostsListRoute,
        PrivateProfileRoute,
        DiscoverExploreRoute,
        FeedMoreRoute,
        OnBoardingCirclesPickerRoute,
        CloseRoute,
        CirclesSideMenuRoute,
        NotificationsListRoute {
  FeedHomeNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
