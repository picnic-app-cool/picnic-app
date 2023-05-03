import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class CircleElectionNavigator with ErrorBottomSheetRoute, AboutElectionsRoute {
  CircleElectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleElectionRoute {
  Future<void> openCircleElection(CircleElectionInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleElectionPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
