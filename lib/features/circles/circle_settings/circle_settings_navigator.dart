import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_navigator.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_navigator.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_navigator.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_navigator.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_page.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_navigator.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_navigator.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_navigator.dart';
import 'package:picnic_app/features/discord/link_discord_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_navigator.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/rules_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';

class CircleSettingsNavigator
    with
        SendPushNotificationRoute,
        CloseRoute,
        BanUserListRoute,
        RemoveReasonRoute,
        ReportedMessageRoute,
        ReportedContentRoute,
        CircleMemberSettingsRoute,
        RulesBottomSheetRoute,
        InviteUserListRoute,
        ErrorBottomSheetRoute,
        SnackBarRoute,
        PostDetailsRoute,
        BlacklistedWordsRoute,
        ProfileRoute,
        BlacklistedWordsRoute,
        ResolvedReportDetailsRoute,
        CommentChatRoute,
        EditCircleRoute,
        ReportsListRoute,
        BannedUsersRoute,
        CircleConfigRoute,
        LinkDiscordRoute,
        RolesListRoute,
        FeatureDisabledBottomSheetRoute {
  CircleSettingsNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin CircleSettingsRoute {
  Future<void> openCircleSettings(CircleSettingsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleSettingsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
