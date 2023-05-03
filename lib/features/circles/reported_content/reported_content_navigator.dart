import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/domain/model/post_report_type.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_page.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ReportedContentNavigator
    with
        RemoveReasonRoute,
        CloseWithResultRoute<PostReportType>,
        BanUserRoute,
        CloseRoute,
        ErrorBottomSheetRoute,
        ResolveReportWithNoActionRoute {
  ReportedContentNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ReportedContentRoute {
  Future<PostReportType?> openReportedContent(ReportedContentInitialParams initialParams) => showPicnicBottomSheet(
        getIt<ReportedContentPage>(param1: initialParams),
      );

  AppNavigator get appNavigator;
}
