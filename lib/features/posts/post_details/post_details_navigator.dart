import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import 'package:picnic_app/features/posts/post_details/post_details_page.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PostDetailsNavigator
    with
        HorizontalActionBottomSheetRoute,
        CloseRoute,
        ReportFormRoute,
        ErrorBottomSheetRoute,
        ConfirmationBottomSheetRoute,
        CloseWithResultRoute<PostRouteResult> {
  PostDetailsNavigator(this.appNavigator);

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

mixin PostDetailsRoute {
  //PostRouteResults has to be nullable when the user decides to not pursuit current action(Eg: presses on close instead of ban user)
  Future<PostRouteResult?> openPostDetails(PostDetailsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PostDetailsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
