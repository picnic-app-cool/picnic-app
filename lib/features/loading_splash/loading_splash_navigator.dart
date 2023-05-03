import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_initial_params.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class LoadingSplashNavigator with NoRoutes {
  LoadingSplashNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

//ignore_for_file: unused-code, unused-files
mixin LoadingSplashRoute {
  Future<void> openLoadingSplash(LoadingSplashInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<LoadingSplashPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
