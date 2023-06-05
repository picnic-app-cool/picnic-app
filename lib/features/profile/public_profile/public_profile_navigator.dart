import 'package:flutter/material.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/profile/collection/collection_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_page.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class PublicProfileNavigator
    with
        CloseRoute,
        FollowersRoute,
        HorizontalActionBottomSheetRoute,
        ErrorBottomSheetRoute,
        ReportFormRoute,
        ShareRoute,
        CollectionRoute,
        FxEffectRoute,
        CircleDetailsRoute,
        SingleChatRoute,
        SingleFeedRoute,
        WebViewRoute,
        CloseWithResultRoute<bool>,
        DiscoverExploreRoute,
        ConfirmationBottomSheetRoute,
        SnackBarRoute,
        AddCirclePodRoute {
  PublicProfileNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin PublicProfileRoute {
  Future<void> openPublicProfile(PublicProfileInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PublicProfilePage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
