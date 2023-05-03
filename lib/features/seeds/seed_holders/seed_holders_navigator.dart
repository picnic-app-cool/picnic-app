import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_page.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class SeedHoldersNavigator with ErrorBottomSheetRoute, ProfileRoute, SeedsRoute, SellSeedsRoute, AboutElectionsRoute {
  SeedHoldersNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin SeedHoldersRoute {
  Future<void> openSeedHolders(SeedHoldersInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SeedHoldersPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
