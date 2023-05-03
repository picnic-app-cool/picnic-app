import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_page.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class ReportedMessageNavigator
    with
        CloseWithResultRoute<bool>,
        BanUserRoute,
        CloseRoute,
        ErrorBottomSheetRoute,
        RemoveReasonRoute,
        ResolveReportWithNoActionRoute {
  ReportedMessageNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ReportedMessageRoute {
  /// Spam message handling have only one action which is banning a user. This bool indicates that.
  Future<bool?> openReportedMessage(ReportedMessageInitialParams initialParams) async {
    return appNavigator.push(
      fadeInRoute(
        getIt<ReportedMessagePage>(param1: initialParams),
        opaque: false,
        fadeOut: false,
      ),
    );
  }

  AppNavigator get appNavigator;
}
