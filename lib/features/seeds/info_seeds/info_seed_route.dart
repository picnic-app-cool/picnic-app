import 'package:picnic_app/features/seeds/info_seeds/info_seed_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin InfoSeedRoute {
  Future<void> openInfoSeeds() => appNavigator.push(picnicModalRoute(const InfoSeedPage()));

  AppNavigator get appNavigator;
}
