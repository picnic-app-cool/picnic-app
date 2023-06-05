import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/profile/collection/collection_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_page.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/seeds/info_seeds/info_seed_route.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class PrivateProfileNavigator
    with
        SettingsHomeRoute,
        NotificationsListRoute,
        FollowersRoute,
        SavedPostsRoute,
        EditProfileRoute,
        SeedsRoute,
        ShareRoute,
        ErrorBottomSheetRoute,
        CollectionRoute,
        CircleDetailsRoute,
        PublicProfileRoute,
        WebViewRoute,
        SingleFeedRoute,
        InviteFriendsBottomSheetRoute,
        CreateCircleRoute,
        DiscoverExploreRoute,
        PostCreationIndexRoute,
        HorizontalActionBottomSheetRoute,
        CloseRoute,
        CloseWithResultRoute<bool>,
        ReportFormRoute,
        SnackBarRoute,
        ConfirmationBottomSheetRoute,
        AddCirclePodRoute,
        InfoSeedRoute,
        SellSeedsRoute,
        CircleDetailsRoute {
  PrivateProfileNavigator(
    this.appNavigator,
  );

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin PrivateProfileRoute {
  Future<void> openPrivateProfile(
    PrivateProfileInitialParams initialParams,
  ) async {
    return appNavigator.push(
      materialRoute(getIt<PrivateProfilePage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
