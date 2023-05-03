import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class BanUserNavigator with CloseWithResultRoute<bool>, CloseRoute, ErrorBottomSheetRoute {
  BanUserNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin BanUserRoute {
  /// True means the user has been banned
  Future<bool?> openBanUser(BanUserInitialParams initialParams) => showPicnicBottomSheet(
        getIt<BanUserPage>(param1: initialParams),
      );

  AppNavigator get appNavigator;
}
