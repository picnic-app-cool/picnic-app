import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/username_verification_data.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_runtime_permission_status_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/register_use_case.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';
import 'package:picnic_app/features/profile/domain/use_cases/edit_profile_use_case.dart';

class OnboardingPresenter extends Cubit<OnboardingViewModel> with SubscriptionsMixin {
  OnboardingPresenter(
    OnboardingPresentationModel model,
    this.navigator,
    this._registerUseCase,
    this._getRuntimePermissionStatusUseCase,
    this._editProfileUseCase,
    UserStore userStore,
  ) : super(model) {
    listenTo<PrivateProfile>(
      stream: userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) {
        tryEmit(_model.copyWith(user: user));
      },
    );
  }

  final OnboardingNavigator navigator;

  static const _userStoreSubscription = "userStoreSubscription";

  final RegisterUseCase _registerUseCase;
  final EditProfileUseCase _editProfileUseCase;

  final GetRuntimePermissionStatusUseCase _getRuntimePermissionStatusUseCase;

  // ignore: unused_element
  OnboardingPresentationModel get _model => state as OnboardingPresentationModel;

  Future<void> onInit() => navigator.openSplash(
        SplashInitialParams(
          onTapLogin: () => _selectFlow(OnboardingFlowType.signIn),
          onTapGetStarted: () => _selectFlow(OnboardingFlowType.signUp),
        ),
      );

  void _selectFlow(OnboardingFlowType flowType) {
    tryEmit(_model.bySelectingFlow(flowType));
    _openNextScreen();
  }

  Future<void> _openNextScreen({bool closePreviousScreens = false}) async {
    final screen = _model.nextScreen;
    if (_model.hasNextScreen) {
      tryEmit(_model.byGoingToNextScreen());
    }
    if (closePreviousScreens) {
      final screensList = _model.screensList;
      await navigator.closeAllOnboardingSteps();
      // this makes sure the screen list exactly as it was before popping all routes (popping routes actually modifies
      // screensList
      tryEmit(_model.copyWith(screensList: screensList));
    }
    unawaited(_performRouting(screen));
  }

  Future<void> _performRouting(OnboardingScreen? screen) async {
    switch (screen) {
      case OnboardingScreen.phone:
        return _openPhone();
      case OnboardingScreen.age:
        return _openAge();
      case OnboardingScreen.codeVerification:
        return _openCodeVerification();
      case OnboardingScreen.username:
        return _openUsername();
      case OnboardingScreen.permissions:
        return _openPermissions();
      case OnboardingScreen.circleGroupings:
        return _openCirclesPickerPage();
      case OnboardingScreen.language:
        return _openLanguage();
      case null:
        return navigator.openMain(const MainInitialParams());
    }
  }

  Future<void> _openPermissions() async {
    await navigator.openPermissionsForm(
      PermissionsFormInitialParams(
        onContinue: (status) {
          _updateFormData((data) => data.copyWith(notificationsStatus: status));

          _openNextScreen();
        },
      ),
    );
    return _handleBackAction(OnboardingScreen.permissions);
  }

  Future<void> _openLanguage() async {
    await navigator.openLanguageSelectForm(
      LanguageSelectFormInitialParams(
        formData: _model.formData,
        onLanguageSelected: (value) {
          _updateFormData((data) => data.copyWith(language: value));
          _openNextScreen();
        },
      ),
    );
    return _handleBackAction(OnboardingScreen.language);
  }

  Future<void> _openCirclesPickerPage() async {
    await navigator.openOnBoardingCirclesPickerPage(
      OnBoardingCirclesPickerInitialParams(
        formData: _model.formData,
        onCirclesSelected: (value) {
          _updateFormData((data) => data.copyWith(circles: value));
          _openNextScreen();
        },
      ),
    );
    return _handleBackAction(OnboardingScreen.circleGroupings);
  }

  Future<void> _openUsername() async {
    await navigator.openUsernameForm(
      UsernameFormInitialParams(
        formData: _model.formData,
        onUsernameSelected: (value) async {
          _updateFormData((data) => data.copyWith(username: value));
          if (_model.flowType == OnboardingFlowType.signUp && await registerUser()) {
            await _openNextScreen(closePreviousScreens: true);
          }
        },
      ),
    );
    return _handleBackAction(OnboardingScreen.username);
  }

  Future<void> _openCodeVerification() async {
    await navigator.openCodeVerificationForm(
      CodeVerificationFormInitialParams(
        onCodeVerified: (authResult) {
          _updateFormData(
            (form) => form.copyWith(
              authResult: authResult,
            ),
          );
          _fixFlowAccordingAuthResult(authResult);
          _openNextScreen();
        },
        formData: _model.formData,
      ),
    );
    return _handleBackAction(OnboardingScreen.codeVerification);
  }

  void _fixFlowAccordingAuthResult(AuthResult authResult) {
    if (authResult.passedOnboarding && _model.flowType == OnboardingFlowType.signUp) {
      // lets switch to sign in flow if user already passed onboarding
      _switchToSignIn();
    }
    if (!authResult.passedOnboarding && _model.flowType == OnboardingFlowType.signIn) {
      // lets switch to signup flow if user didnt pass onboarding after signing in
      _switchToSignUp();
    }
  }

  void _switchToSignIn() {
    tryEmit(
      _model.bySelectingFlow(
        OnboardingFlowType.signIn,
        removeScreens: [
          OnboardingScreen.phone,
          OnboardingScreen.codeVerification,
        ],
      ),
    );
  }

  void _switchToDiscord() {
    tryEmit(
      _model.bySelectingFlow(
        OnboardingFlowType.discord,
        removeScreens: [
          if (!_model.user.agePending) OnboardingScreen.age,
          OnboardingScreen.language,
          OnboardingScreen.phone,
          OnboardingScreen.codeVerification,
          OnboardingScreen.username,
          OnboardingScreen.permissions,
          if (!_model.user.circlesPending) OnboardingScreen.circleGroupings,
        ],
      ),
    );
  }

  void _switchToSignUp() {
    tryEmit(
      _model.bySelectingFlow(
        OnboardingFlowType.signUp,
        removeScreens: [
          OnboardingScreen.phone,
          OnboardingScreen.codeVerification,
        ],
      ),
    );
  }

  Future<void> _openAge() async {
    await navigator.openAgeForm(
      AgeFormInitialParams(
        formData: _model.formData,
        onAgeSelected: (age) async {
          _updateFormData((data) => data.copyWith(age: age));

          if (_model.flowType == OnboardingFlowType.discord) {
            await _editProfileUseCase
                .execute(
                  age: int.tryParse(age),
                )
                .doOn(
                  success: (success) => _openNextScreen(),
                  fail: (fail) => navigator.showError(
                    fail.displayableFailure(),
                  ),
                );
          } else {
            await _openNextScreen();
          }
        },
      ),
    );
    return _handleBackAction(OnboardingScreen.age);
  }

  Future<void> _openPhone() async {
    await navigator.openPhoneForm(
      PhoneFormInitialParams(
        formType: _model.flowType,
        formData: _model.formData,
        onTapDiscord: () => _switchToDiscord(),
        onChangedPhone: (data) {
          _updateFormData(
            (form) => form.copyWith(
              phoneVerificationData: data.phoneVerificationData ?? const PhoneVerificationData.empty(),
              authResult: data.authResult ?? const AuthResult.empty(),
              usernameVerificationData: data.usernameVerificationData ?? const UsernameVerificationData.empty(),
            ),
          );

          if (data.phoneVerificationData == null && data.usernameVerificationData == null) {
            //Social login. Remove code verification screen
            tryEmit(_model.byRemovingScreen(OnboardingScreen.codeVerification));
            _fixFlowAccordingAuthResult(_model.formData.authResult);
          }

          _checkRuntimePermissions();
        },
      ),
    );
    return _handleBackAction(OnboardingScreen.phone);
  }

  void _updateFormData(
    OnboardingFormData Function(OnboardingFormData) updater,
  ) =>
      tryEmit(_model.byUpdatingFormData(updater));

  /// called after screen exits with back button or equivalent, putting back
  /// the screen into the [_model]'s screensList
  Future<void> _handleBackAction(OnboardingScreen? screen) async => tryEmit(
        _model.copyWith(
          screensList: screen == null ? null : [screen, ..._model.screensList],
        ),
      );

  //ignore: member-ordering
  Future<bool> registerUser() async {
    if (_model.registerFutureResult.isPending()) {
      return false;
    } else if (_model.registerFutureResult.result?.isSuccess == true) {
      return true;
    }
    return _registerUseCase
        .execute(formData: _model.formData) //
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(registerFutureResult: result)),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        )
        .asyncFold(
          (fail) => false,
          (success) => true,
        );
  }

  void _checkRuntimePermissions() {
    _getRuntimePermissionStatusUseCase
        .execute(
          permission: RuntimePermission.notifications,
        )
        .doOn(
          success: (status) => _handleNotificationsPermissionResponse(status),
        );
    _getRuntimePermissionStatusUseCase
        .execute(
          permission: RuntimePermission.contacts,
        )
        .doOn(
          success: (status) => _handleContactsPermissionResponse(status),
        );
    _continueIfNothingToRequest();
  }

  void _handleNotificationsPermissionResponse(RuntimePermissionStatus status) {
    _model.copyWith(notificationsPermissionStatus: status);
  }

  void _handleContactsPermissionResponse(RuntimePermissionStatus status) {
    _model.copyWith(contactsPermissionStatus: status);
  }

  void _continueIfNothingToRequest() {
    if (!_model.showPermissionsScreen) {
      _model.byRemovingScreen(OnboardingScreen.permissions);
    }
    _openNextScreen();
  }
}
