import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_page.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/changing_pinned_comment_route.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/comment_actions_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/web_view_route.dart';

class CommentChatNavigator
    with
        CommentChatRoute,
        WebViewRoute,
        CircleDetailsRoute,
        ProfileRoute,
        ErrorBottomSheetRoute,
        FxEffectRoute,
        ReportedContentRoute,
        CloseRoute,
        CommentActionsRoute,
        ShareRoute,
        ConfirmationBottomSheetRoute,
        CloseWithResultRoute<bool>,
        ReportFormRoute,
        ChangingPinnedCommentRoute {
  CommentChatNavigator(this.appNavigator, this.userStore);

  @override
  final UserStore userStore;

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;
}

mixin CommentChatRoute {
  Future<void> openCommentChat(CommentChatInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CommentChatPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
