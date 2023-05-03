import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_desktop_app/features/main/main_navigator.dart';

class AppInitNavigator with MainRoute, OnboardingRoute, ErrorBottomSheetRoute {
  AppInitNavigator(
    this.appNavigator,
    this.featureFlagsStore,
  );

  @override
  final AppNavigator appNavigator;

  @override
  final FeatureFlagsStore featureFlagsStore;
}
