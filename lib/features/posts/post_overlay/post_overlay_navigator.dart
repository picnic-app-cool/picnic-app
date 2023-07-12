import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/post_share/post_share_navigator.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/comment_actions_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';

class PostOverlayNavigator
    with
        CommentChatRoute,
        ReportedContentRoute,
        ShareRoute,
        CircleDetailsRoute,
        ProfileRoute,
        ErrorBottomSheetRoute,
        CloseRoute,
        ReportFormRoute,
        PostShareRoute,
        CommentActionsRoute,
        SnackBarRoute,
        SavePostToCollectionRoute {
  PostOverlayNavigator(this.appNavigator, this.userStore);

  @override
  final UserStore userStore;

  @override
  final AppNavigator appNavigator;
}
