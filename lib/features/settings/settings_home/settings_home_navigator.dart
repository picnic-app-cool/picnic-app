import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_navigator.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_navigator.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_navigator.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_navigator.dart';
import 'package:picnic_app/features/settings/language/language_navigator.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_navigator.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_navigator.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_page.dart';
import 'package:picnic_app/navigation/app_info_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/url_route.dart';

class SettingsHomeNavigator
    with
        CloseRoute,
        LanguageRoute,
        BlockedListRoute,
        CommunityGuidelinesRoute,
        GetVerifiedRoute,
        NotificationSettingsRoute,
        ConfirmationBottomSheetRoute,
        PrivacySettingsRoute,
        ShareRoute,
        ErrorBottomSheetRoute,
        OnboardingRoute,
        AppInfoBottomSheetRoute,
        InviteFriendsRoute,
        ReportFormRoute,
        UrlRoute {
  SettingsHomeNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SettingsHomeRoute {
  void openSettingsHome(SettingsHomeInitialParams initialParams) {
    appNavigator.push(
      materialRoute(getIt<SettingsHomePage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
