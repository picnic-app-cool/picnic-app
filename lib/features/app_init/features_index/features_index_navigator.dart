import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_initial_params.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_page.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_navigator.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_navigator.dart';
import 'package:picnic_app/features/discord/link_discord_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/force_update/force_update_navigator.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_navigator.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/info_seeds/info_seed_route.dart';
import 'package:picnic_app/features/seeds/new_seeds/new_seed_route.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/video_editor/video_editor_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class FeaturesIndexNavigator
    with
        OnboardingRoute,
        PrivateProfileRoute,
        DiscoverExploreRoute,
        PublicProfileRoute,
        PhotoEditorRoute,
        SendPushNotificationRoute,
        PhotoEditorRoute,
        PublicProfileRoute,
        VideoEditorRoute,
        NotificationsRoute,
        CircleSettingsRoute,
        SellSeedsRoute,
        CircleElectionRoute,
        NewSeedRoute,
        InfoSeedRoute,
        MainRoute,
        FxEffectRoute,
        CircleDetailsRoute,
        CreateSliceRoute,
        SliceDetailsRoute,
        ForceUpdateRoute,
        CircleRoleRoute,
        OnBoardingCirclesPickerRoute,
        AboutElectionsRoute,
        LinkDiscordRoute {
  FeaturesIndexNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin FeaturesIndexRoute {
  Future<void> openFeaturesIndex(FeaturesIndexInitialParams initialParams) async {
    appNavigator.popUntilRoot(AppNavigator.currentContext);
    return appNavigator.push(
      materialRoute(getIt<FeaturesIndexPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
