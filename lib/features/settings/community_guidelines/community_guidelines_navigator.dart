import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class CommunityGuidelinesNavigator with ReportFormRoute {
  CommunityGuidelinesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CommunityGuidelinesRoute {
  void openCommunityGuidelines(CommunityGuidelinesInitialParams initialParams) {
    appNavigator.push(
      materialRoute(getIt<CommunityGuidelinesPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
