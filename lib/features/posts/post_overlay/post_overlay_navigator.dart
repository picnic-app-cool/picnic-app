import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
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
        PublicProfileRoute,
        PrivateProfileRoute,
        ErrorBottomSheetRoute,
        CloseRoute,
        ReportFormRoute,
        CommentActionsRoute,
        SnackBarRoute,
        SavePostToCollectionRoute {
  PostOverlayNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
