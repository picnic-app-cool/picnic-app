import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_navigator.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_navigator.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_page.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';

class SliceDetailsNavigator
    with
        EditSliceRulesRoute,
        ProfileRoute,
        CloseRoute,
        SnackBarRoute,
        InviteUserToSliceRoute,
        ReportFormRoute,
        JoinRequestsRoute,
        SliceSettingsRoute,
        ErrorBottomSheetRoute,
        CloseWithResultRoute<SliceSettingsPageResult> {
  SliceDetailsNavigator(
    this.appNavigator,
    this.userStore,
  );

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin SliceDetailsRoute {
  Future<SliceSettingsPageResult?> openSliceDetails(
    SliceDetailsInitialParams initialParams, {
    bool pushAsReplacement = false,
  }) async =>
      appNavigator.push(
        materialRoute(getIt<SliceDetailsPage>(param1: initialParams)),
      );

  AppNavigator get appNavigator;
}
