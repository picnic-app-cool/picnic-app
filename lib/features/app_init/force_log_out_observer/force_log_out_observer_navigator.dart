import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class ForceLogOutObserverNavigator with OnboardingRoute {
  ForceLogOutObserverNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
