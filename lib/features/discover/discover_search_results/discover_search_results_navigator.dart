import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_page.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class DiscoverSearchResultsNavigator with CloseRoute, ErrorBottomSheetRoute, ProfileRoute, CircleDetailsRoute {
  DiscoverSearchResultsNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin DiscoverSearchResultsRoute {
  Future<void> openDiscoverSearchResults(DiscoverSearchResultsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<DiscoverSearchResultsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
