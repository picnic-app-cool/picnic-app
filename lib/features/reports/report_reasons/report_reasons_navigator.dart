import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_initial_params.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ReportReasonsNavigator with CloseWithResultRoute<ReportReason> {
  ReportReasonsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ReportReasonsRoute {
  Future<ReportReason?> openReportReasons(
    ReportReasonsInitialParams initialParams,
  ) async {
    return showPicnicBottomSheet(
      getIt<ReportReasonsPage>(param1: initialParams),
      useRootNavigator: true,
    );
  }

  AppNavigator get appNavigator;
}
