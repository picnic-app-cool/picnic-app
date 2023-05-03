import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ResolvedReportDetailsNavigator with CloseWithResultRoute<bool>, ErrorBottomSheetRoute {
  ResolvedReportDetailsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ResolvedReportDetailsRoute {
  Future<bool?> openReportDetails(ResolvedReportDetailsInitialParams initialParams) async =>
      showPicnicBottomSheet<bool?>(
        getIt<ResolvedReportDetailsPage>(param1: initialParams),
      );

  AppNavigator get appNavigator;
}
