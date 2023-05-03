import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/log_console/log_console_initial_params.dart';
import 'package:picnic_app/features/debug/log_console/log_console_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/share_route.dart';

class LogConsoleNavigator with NoRoutes, ShareRoute, ErrorBottomSheetRoute {
  LogConsoleNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin LogConsoleRoute {
  Future<void> openLogConsole(LogConsoleInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<LogConsolePage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
