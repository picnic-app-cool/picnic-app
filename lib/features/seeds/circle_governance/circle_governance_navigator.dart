import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class CircleGovernanceNavigator with ErrorBottomSheetRoute, AboutElectionsRoute, CircleElectionRoute, ProfileRoute {
  CircleGovernanceNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;
}

mixin CircleGovernanceRoute {
  Future<void> openCircleGovernance(CircleGovernanceInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(CircleGovernancePage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
