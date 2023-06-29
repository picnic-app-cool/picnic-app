import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/app_init_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/app_init/app_init_navigator.dart';
import 'package:picnic_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_app/features/force_update/domain/use_case/should_show_force_update_use_case.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/user_agreement/domain/use_cases/accept_apps_terms_use_case.dart';
import 'package:picnic_app/features/user_agreement/domain/use_cases/has_user_agreed_to_apps_terms_use_case.dart';

class AppInitPresenter extends Cubit<AppInitViewModel> with SubscriptionsMixin {
  AppInitPresenter(
    AppInitPresentationModel model,
    this.navigator,
    this.appInitUseCase,
    this.shouldShowForceUpdateUseCase,
    this.hasUserAgreedToAppsTermsUseCase,
    this.acceptAppsTermsUseCase,
    this._userStore,
  ) : super(model) {
    listenTo<PrivateProfile>(
      stream: _userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) {
        tryEmit(_model.copyWith(user: user));
      },
    );
  }

  final HasUserAgreedToAppsTermsUseCase hasUserAgreedToAppsTermsUseCase;
  final AcceptAppsTermsUseCase acceptAppsTermsUseCase;
  final ShouldShowForceUpdateUseCase shouldShowForceUpdateUseCase;
  final AppInitNavigator navigator;
  final AppInitUseCase appInitUseCase;
  final UserStore _userStore;

  static const _userStoreSubscription = "userStoreSubscription";

  AppInitPresentationModel get _model => state as AppInitPresentationModel;

  Future<void> onInit() async {
    final shouldShowForceUpdate = await shouldShowForceUpdateUseCase.execute();
    if (shouldShowForceUpdate) {
      await navigator.openForceUpdate(
        const ForceUpdateInitialParams(),
      );
    } else {
      await _executeInitUseCase();
    }
  }

  Future<void> onLogoAnimationEnd() async {
    if (_model.appInitResult.status == FutureStatus.fulfilled) {
      await _onAppInitSuccess();
    }
  }

  Future<void> _executeInitUseCase() async {
    await appInitUseCase
        .execute() //
        .observeStatusChanges((result) => tryEmit(_model.copyWith(appInitResult: result)))
        .doOn(
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
        );
  }

  Future<void> _onAppInitSuccess() async {
    if (_model.isUserLoggedIn) {
      await _navigateBasedOnUserAgreement();
    } else {
      await navigator.openOnboarding(const OnboardingInitialParams());
    }
  }

  Future<void> _navigateBasedOnUserAgreement() async {
    final userAgreedToTerms = await hasUserAgreedToAppsTermsUseCase.execute().asyncFold(
          (fail) => false,
          (agreed) => agreed,
        );
    if (userAgreedToTerms) {
      await _navigateToMain();
    } else {
      await navigator.openUserAgreementBottomSheet(
        onTapTerms: () => navigator.openUrl(Constants.termsUrl),
        onTapPolicies: () => navigator.openUrl(Constants.policiesUrl),
        onTapAccept: () {
          acceptAppsTermsUseCase.execute();
          navigator.openMain(const MainInitialParams());
        },
      );
    }
  }

  Future<void> _navigateToMain() async {
    await navigator.openMain(const MainInitialParams());
  }
}
