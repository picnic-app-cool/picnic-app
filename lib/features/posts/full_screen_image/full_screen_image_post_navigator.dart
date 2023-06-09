import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_page.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class FullScreenImagePostNavigator
    with
        CloseRoute,
        HorizontalActionBottomSheetRoute,
        ConfirmationBottomSheetRoute,
        ErrorBottomSheetRoute,
        CircleDetailsRoute,
        ProfileRoute,
        CloseWithResultRoute<PostRouteResult>,
        ReportFormRoute,
        ShareRoute,
        SnackBarRoute,
        SavePostToCollectionRoute,
        CommentChatRoute {
  FullScreenImagePostNavigator(this.appNavigator, this.userStore);

  @override
  final UserStore userStore;

  @override
  final AppNavigator appNavigator;

  void onTapMore({
    VoidCallback? onTapDeletePost,
    VoidCallback? onTapReport,
  }) =>
      showHorizontalActionBottomSheet(
        actions: [
          if (onTapReport != null)
            ActionBottom(
              label: appLocalizations.reportAction,
              action: onTapReport,
              icon: Assets.images.infoOutlined.path,
            ),
          if (onTapDeletePost != null)
            ActionBottom(
              label: appLocalizations.delete,
              action: onTapDeletePost,
              icon: Assets.images.delete.path,
            ),
        ],
        onTapClose: appNavigator.close,
      );
}

mixin FullScreenImagePostRoute {
  Future<void> openFullScreenImagePost(FullScreenImagePostInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<FullScreenImagePostPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
