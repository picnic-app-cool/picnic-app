import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_page.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class DeleteAccountReasonsNavigator with NoRoutes, CloseWithResultRoute<DeleteAccountReason> {
  DeleteAccountReasonsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin DeleteAccountReasonsRoute {
  Future<DeleteAccountReason?> openDeleteAccountReasons(
    DeleteAccountReasonsInitialParams initialParams,
  ) async {
    return showPicnicBottomSheet(
      getIt<DeleteAccountReasonsPage>(param1: initialParams),
    );
  }

  AppNavigator get appNavigator;
}
