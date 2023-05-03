import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_bottom_sheet_page.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class SliceSettingsNavigator
    with
        CloseRoute,
        SliceDetailsRoute,
        ShareRoute,
        ReportFormRoute,
        ErrorBottomSheetRoute,
        CloseWithResultRoute<SliceSettingsPageResult>,
        CreateSliceRoute,
        CloseWithResultRoute<SliceSettingsPageResult>,
        ConfirmationBottomSheetRoute {
  SliceSettingsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SliceSettingsRoute {
  Future<SliceSettingsPageResult?> openSliceSettingsBottomSheet(
    SliceSettingsInitialParams initialParams,
  ) async =>
      showPicnicBottomSheet(
        getIt<SliceSettingsBottomSheetPage>(param1: initialParams),
      );
}
