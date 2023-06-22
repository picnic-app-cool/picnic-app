import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_page.dart';
import 'package:picnic_app/features/social_accounts/link_social_account_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/url_route.dart';

class ConnectAccountsNavigator with NoRoutes, UrlRoute, ErrorBottomSheetRoute, LinkSocialAccountBottomSheetRoute {
  ConnectAccountsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ConnectAccountsRoute {
  Future<void> openConnectAccounts(ConnectAccountsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(ConnectAccountsPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
