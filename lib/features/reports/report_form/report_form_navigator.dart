import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/reports/report_form/report_form_page.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_alert_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class ReportFormNavigator
    with ReportReasonsRoute, ConfirmationAlertRoute, CloseRoute, ErrorBottomSheetRoute, CloseWithResultRoute<bool> {
  ReportFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ReportFormRoute {
  Future<bool?> openReportForm(ReportFormInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<ReportFormPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
