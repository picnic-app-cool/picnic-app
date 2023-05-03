import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ResolveReportWithNoActionNavigator with CloseRoute, ErrorBottomSheetRoute, CloseWithResultRoute<bool> {
  ResolveReportWithNoActionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ResolveReportWithNoActionRoute {
  Future<bool?> openResolveReportWithNoAction(ResolveReportWithNoActionInitialParams initialParams) =>
      showPicnicBottomSheet(
        getIt<ResolveReportWithNoActionPage>(param1: initialParams),
      );

  AppNavigator get appNavigator;
}
