import 'package:picnic_app/features/force_update/force_update_navigator.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/user_agreement/user_agreement_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/url_route.dart';

class AppInitNavigator
    with
        ErrorBottomSheetRoute,
        MainRoute,
        CloseRoute,
        OnboardingRoute,
        ForceUpdateRoute,
        UserAgreementRoute,
        UrlRoute,
        OnBoardingCirclesPickerRoute {
  AppInitNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
