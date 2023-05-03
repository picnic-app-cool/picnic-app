import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class JoinRequestsNavigator with NoRoutes, ErrorBottomSheetRoute {
  JoinRequestsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin JoinRequestsRoute {
  Future<void> openJoinRequests(JoinRequestsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<JoinRequestsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
