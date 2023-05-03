import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/main/main_initial_params.dart' as picnic_app;
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/main/main_page.dart' as picnic_app;
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/features/main/main_page.dart';

class DesktopOnboardingNavigator extends OnboardingNavigator {
  DesktopOnboardingNavigator(
    super.appNavigator,
    super.navigatorKey,
    this._featureFlagsStore,
  );

  final FeatureFlagsStore _featureFlagsStore;

  @override
  Future<void> openMain(picnic_app.MainInitialParams initialParams) async {
    final page = _featureFlagsStore.featureFlags[FeatureFlagType.useDesktopUiOnDesktop]
        ? getIt<MainPage>(param1: const MainInitialParams())
        : getIt<picnic_app.MainPage>(param1: initialParams);

    return appNavigator.pushAndRemoveUntilRoot(
      fadeInRoute(
        page,
        pageName: MainNavigator.routeName,
      ),
    );
  }
}
