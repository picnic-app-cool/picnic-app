import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_page.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class DeleteAccountNavigator with DeleteAccountReasonsRoute, ErrorBottomSheetRoute, OnboardingRoute {
  DeleteAccountNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin DeleteAccountRoute {
  Future<void> openDeleteAccount(DeleteAccountInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<DeleteAccountPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
