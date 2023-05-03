import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_page.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/reached_list_end_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class SingleFeedNavigator
    with
        HorizontalActionBottomSheetRoute,
        ConfirmationBottomSheetRoute,
        ReportFormRoute,
        CloseRoute,
        ReachedListEndRoute,
        ErrorBottomSheetRoute {
  SingleFeedNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  @override
  late BuildContext context;

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

mixin SingleFeedRoute {
  Future<void> openSingleFeed(SingleFeedInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SingleFeedPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
