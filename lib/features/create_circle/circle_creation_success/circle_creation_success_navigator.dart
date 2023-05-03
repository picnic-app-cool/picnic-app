import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_page.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';

class CircleCreationSuccessNavigator
    with MainRoute, ShareRoute, CloseRoute, ErrorBottomSheetRoute, PrivateProfileRoute {
  CircleCreationSuccessNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleCreationSuccessRoute {
  Future<void> openCircleCreationSuccess(CircleCreationSuccessInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleCreationSuccessPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
