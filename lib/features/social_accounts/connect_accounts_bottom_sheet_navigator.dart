import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_page.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/url_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ConnectAccountsBottomSheetNavigator with NoRoutes, UrlRoute, ErrorBottomSheetRoute, ConnectAccountsRoute {
  ConnectAccountsBottomSheetNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ConnectAccountsBottomSheetRoute {
  Future<void> openConnectAccountsBottomSheet(ConnectAccountsBottomSheetInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<ConnectAccountsBottomSheetPage>(param1: initialParams),
      useRootNavigator: true,
    );
  }
}
