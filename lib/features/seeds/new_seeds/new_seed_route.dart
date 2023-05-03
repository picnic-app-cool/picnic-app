import 'package:picnic_app/features/seeds/new_seeds/new_seed_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin NewSeedRoute {
  Future<void> openNewSeeds() => appNavigator.push(picnicModalRoute(const NewSeedPage()));

  AppNavigator get appNavigator;
}
