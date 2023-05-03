import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/seeds/info_seeds/info_seed_route.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class SeedsNavigator with InfoSeedRoute, ErrorBottomSheetRoute, SellSeedsRoute, CircleDetailsRoute {
  SeedsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SeedsRoute {
  Future<void> openSeeds(SeedsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SeedsPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
