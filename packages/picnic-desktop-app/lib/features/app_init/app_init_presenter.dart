import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/app_init_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_desktop_app/core/domain/use_cases/enable_launch_at_startup_use_case.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_navigator.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';

class AppInitPresenter extends Cubit<AppInitViewModel> with SubscriptionsMixin {
  AppInitPresenter(
    super.model,
    this.navigator,
    this.appInitUseCase,
    UserStore userStore,
    this._enableLaunchAtStartupUseCase,
  ) {
    listenTo<PrivateProfile>(
      stream: userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) {
        tryEmit(_model.copyWith(user: user));
      },
    );
  }

  final AppInitNavigator navigator;
  final AppInitUseCase appInitUseCase;
  final EnableLaunchAtStartupUseCase _enableLaunchAtStartupUseCase;

  static const _userStoreSubscription = 'userStoreSubscription';

  // ignore: unused_element
  AppInitPresentationModel get _model => state as AppInitPresentationModel;

  Future<void> onInit() async {
    await appInitUseCase
        .execute() //
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(appInitResult: result)),
        )
        .doOn(
          success: (_) => _onAppInitSuccess(),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
    await _enableLaunchAtStartupUseCase.execute();
  }

  void _onAppInitSuccess() {
    if (_model.isUserLoggedIn) {
      navigator.openMain(const MainInitialParams());
    } else {
      navigator.openOnboarding(const OnboardingInitialParams());
    }
  }
}
