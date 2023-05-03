import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/force_update/force_update_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

//ignore_for_file: unused-code, unused-files
class ForceUpdateNavigator with NoRoutes, ErrorBottomSheetRoute {
  ForceUpdateNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ForceUpdateRoute {
  Future<void> openForceUpdate(ForceUpdateInitialParams initialParams) async {
    return appNavigator.pushReplacement(
      materialRoute(getIt<ForceUpdatePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
