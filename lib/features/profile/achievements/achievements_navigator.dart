import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/achievements/achievements_initial_params.dart';
import 'package:picnic_app/features/profile/achievements/achievements_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/no_routes.dart';

//TODO remove achievements route from here
class AchievementsNavigator with NoRoutes, AchievementsRoute {
  AchievementsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AchievementsRoute {
  Future<void> openAchievements(AchievementsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<AchievementsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
