import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class AboutElectionsNavigator with CircleCreationSuccessRoute {
  AboutElectionsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AboutElectionsRoute {
  Future<void> openAboutElections(AboutElectionsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<AboutElectionsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
