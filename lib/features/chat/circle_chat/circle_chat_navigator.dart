import 'package:flutter/widgets.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_page.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_navigator.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_navigator.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/message_copied_route.dart';
import 'package:picnic_app/navigation/no_access_to_gallery_route.dart';
import 'package:picnic_app/navigation/save_attachments_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class CircleChatNavigator
    with
        CircleChatSettingsRoute,
        CloseRoute,
        ReportFormRoute,
        ErrorBottomSheetRoute,
        PublicProfileRoute,
        MessageActionsRoute,
        PrivateProfileRoute,
        WebViewRoute,
        PostDetailsRoute,
        FullscreenAttachmentRoute,
        SaveAttachmentsRoute,
        NoAccessToGalleryRoute,
        MessageCopiedRoute,
        FeatureDisabledBottomSheetRoute {
  CircleChatNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin CircleChatRoute {
  Future<void> openCircleChat(CircleChatInitialParams initialParams, {bool pushAsReplacement = false}) {
    final route = materialRoute(getIt<CircleChatPage>(param1: initialParams));
    return pushAsReplacement
        ? appNavigator.pushReplacement(
            route,
            useRoot: true,
          )
        : appNavigator.push(
            route,
            useRoot: true,
          );
  }

  AppNavigator get appNavigator;
}
