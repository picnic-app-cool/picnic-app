import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_navigator.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_page.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_navigator.dart';
import 'package:picnic_app/features/onboarding/splash/splash_navigator.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class OnboardingNavigator
    with
        SplashRoute,
        UsernameFormRoute,
        CountrySelectFormRoute,
        AgeFormRoute,
        MethodFormRoute,
        CodeVerificationFormRoute,
        LanguageSelectFormRoute,
        ProfilePhotoFormRoute,
        PermissionsFormRoute,
        PhoneFormRoute,
        OnBoardingCirclesPickerRoute,
        MainRoute,
        ErrorBottomSheetRoute,
        GenderSelectFormRoute {
  const OnboardingNavigator(
    this.appNavigator,
    this.navigatorKey,
  );

  @override
  final AppNavigator appNavigator;
  final OnboardingNavigatorKey navigatorKey;

  @override
  BuildContext? get context => navigatorKey.currentContext;

  Future<void> closeAllOnboardingSteps() async {
    appNavigator.popUntilRoot(context);
    // we need to await all futures from navigation to complete and be properly processed before we can
    // continue. This makes sure all data processing of popped routes is handled
    await Future.delayed(const Duration(milliseconds: 1));
  }
}

mixin OnboardingRoute {
  Future<void> openOnboarding(OnboardingInitialParams initialParams) async {
    _prepareNavigatorKey();
    return appNavigator.pushReplacement(
      noTransitionRoute(getIt<OnboardingPage>(param1: initialParams)),
    );
  }

  Future<void> replaceAllToOnboarding(OnboardingInitialParams initialParams) async {
    _prepareNavigatorKey();
    return appNavigator.pushAndRemoveUntilRoot(
      materialRoute(getIt<OnboardingPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;

  void _prepareNavigatorKey() {
    // this makes sure navigator key is created freshly each time for new instance
    if (getIt.isRegistered<OnboardingNavigatorKey>()) {
      getIt.unregister<OnboardingNavigatorKey>();
    }
    final navigatorKey = OnboardingNavigatorKey();
    getIt.registerFactory(() => navigatorKey);
  }
}

typedef OnboardingNavigatorKey = GlobalKey<NavigatorState>;
