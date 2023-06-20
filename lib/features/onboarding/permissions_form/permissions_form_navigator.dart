import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class PermissionsFormNavigator with CloseRoute, ErrorBottomSheetRoute {
  PermissionsFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PermissionsFormRoute {
  Future<void> openPermissionsForm(PermissionsFormInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<PermissionsFormPage>(param1: initialParams),
      useRootNavigator: true,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
