import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/domain/model/gender.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/domain/validators/onboarding_form_validator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presenter.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late OnboardingPresentationModel model;
  late OnboardingPresenter presenter;
  late MockOnboardingNavigator navigator;
  late Completer<void> navigationCompleter;

  void _mockCodeVerification(
    MockOnboardingNavigator navigator, {
    required bool passedOnboarding,
  }) {
    when(() => navigator.openCodeVerificationForm(any())).thenAnswer((invocation) {
      invocation.initParams<CodeVerificationFormInitialParams>().onCodeVerified(
            const AuthResult.empty().copyWith(
              authToken: passedOnboarding ? Stubs.authToken : null,
              userId: const Id("userId"),
            ),
          );
      return navigationCompleter.future;
    });
  }

  void _mockLogInFlow(MockOnboardingNavigator navigator) {
    when(() => navigator.openSplash(any())).thenAnswer((invocation) {
      invocation.initParams<SplashInitialParams>().onTapLogin();
      return navigationCompleter.future;
    });
  }

  void _mockRegisterFlow(MockOnboardingNavigator navigator) {
    when(() => navigator.openSplash(any())).thenAnswer((invocation) {
      invocation.initParams<SplashInitialParams>().onTapGetStarted();
      return navigationCompleter.future;
    });
  }

  test(
    'signIn flow should show screens in order',
    () => fakeAsync((async) {
      _mockLogInFlow(navigator);
      _mockCodeVerification(navigator, passedOnboarding: true);

      unawaited(presenter.onInit());
      async.flushMicrotasks();
      verifyInOrder([
        () => navigator.openSplash(any()),
        () => navigator.openMethodForm(any()),
        () => navigator.openPhoneForm(any()),
        () => navigator.openCodeVerificationForm(any()),
        () => navigator.openPermissionsForm(any()),
        () => navigator.openMain(any()),
      ]);
      verifyNoMoreInteractions(navigator);
    }),
  );

  test(
    'signUp flow should show screens in order',
    () => fakeAsync(
      (async) {
        _mockRegisterFlow(navigator);
        unawaited(presenter.onInit());
        async.flushMicrotasks();
        verifyInOrder([
          () => navigator.openSplash(any()),
          () => navigator.openMethodForm(any()),
          () => navigator.openAgeForm(any()),
          () => navigator.openPhoneForm(any()),
          () => navigator.openCodeVerificationForm(any()),
          () => navigator.openGenderSelectForm(any()),
          () => navigator.openOnBoardingCirclesPickerPage(any()),
          () => navigator.openUsernameForm(any()),
          () => OnboardingMocks.registerUseCase.execute(formData: any(named: "formData")),
          () => navigator.closeAllOnboardingSteps(),
          () => navigator.openPermissionsForm(any()),
          () => navigator.openMain(any()),
        ]);
        verifyNoMoreInteractions(navigator);
      },
    ),
  );

  test(
    'when signUp fails, user is presented with error and stays on profile photo screen',
    () => fakeAsync(
      (async) {
        _mockRegisterFlow(navigator);
        when(() => OnboardingMocks.registerUseCase.execute(formData: any(named: "formData"))).thenAnswer(
          (invocation) => failFuture(
            const RegisterFailure.validationError(OnboardingValidationError.missingUsername),
          ),
        );

        unawaited(presenter.onInit());
        async.flushMicrotasks();
        verifyInOrder([
          () => navigator.openSplash(any()),
          () => navigator.openMethodForm(any()),
          () => navigator.openAgeForm(any()),
          () => navigator.openPhoneForm(any()),
          () => navigator.openCodeVerificationForm(any()),
          () => navigator.openGenderSelectForm(any()),
          () => navigator.openOnBoardingCirclesPickerPage(any()),
          () => navigator.openUsernameForm(any()),
          () => OnboardingMocks.registerUseCase.execute(formData: any(named: "formData")),
          () => navigator.showError(any()),
        ]);
        verifyNoMoreInteractions(navigator);
      },
    ),
  );

  test(
    'when signUp succeeds, consecutive calls to register should succeed without calling usecase',
    () {
      fakeAsync(
        (async) async {
          //this handles the case where user managed to get back to the username screen after it successfully registered
          // we want to prevent the signup call to run in such case and just proceed further to circle selection
          _mockRegisterFlow(navigator);
          when(() => OnboardingMocks.registerUseCase.execute(formData: any(named: "formData")))
              .thenSuccess((_) => Stubs.privateProfile);
          when(() => navigator.openOnBoardingCirclesPickerPage(any())).thenAnswer((invocation) {
            return Future.value();
          });

          unawaited(presenter.onInit());
          async.flushTimers();
          async.flushMicrotasks();
          unawaited(presenter.registerUser());
        },
      );
      verify(() => OnboardingMocks.registerUseCase.execute(formData: any(named: 'formData'))).called(1);
      verifyNoMoreInteractions(OnboardingMocks.registerUseCase);
    },
  );

  test(
    'when signUp succeeds, screens list should not contain any of the previous screens and all previous screens should be popped',
    () {
      fakeAsync(
        (async) {
          _mockRegisterFlow(navigator);
          when(() => OnboardingMocks.registerUseCase.execute(formData: any(named: "formData")))
              .thenSuccess((_) => Stubs.privateProfile);
          when(() => navigator.openPermissionsForm(any())).thenAnswer((invocation) {
            return Future.value();
          });

          unawaited(presenter.onInit());
          async.flushMicrotasks();
          async.flushTimers();
          verify(() => navigator.closeAllOnboardingSteps());
          expect(
            (presenter.state as OnboardingPresentationModel).screensList,
            [
              OnboardingScreen.permissions,
            ],
          );
        },
      );
    },
  );

  setUp(() {
    reset(OnboardingMocks.registerUseCase);
    model = OnboardingPresentationModel.initial(const OnboardingInitialParams());
    navigator = MockOnboardingNavigator();
    presenter = OnboardingPresenter(
      model,
      navigator,
      OnboardingMocks.registerUseCase,
      Mocks.getRuntimePermissionStatusUseCase,
      ProfileMocks.editProfileUseCase,
      Mocks.userStore,
    );
    navigationCompleter = Completer();
    when(() => navigator.openLanguageSelectForm(any())).thenAnswer((invocation) {
      invocation.initParams<LanguageSelectFormInitialParams>().onLanguageSelected(const Language.empty());
      return navigationCompleter.future;
    });

    when(() => navigator.openGenderSelectForm(any())).thenAnswer((invocation) {
      invocation.initParams<GenderSelectFormInitialParams>().onGenderSelected(Gender.female);
      return navigationCompleter.future;
    });

    when(() => navigator.openMethodForm(any())).thenAnswer((invocation) {
      invocation.initParams<MethodFormInitialParams>().onChangedPhone(
            const PhonePageResult(
              phoneVerificationData: PhoneVerificationData.empty(),
            ),
          );
      return navigationCompleter.future;
    });
    _mockRegisterFlow(navigator);
    when(() => navigator.openAgeForm(any())).thenAnswer((invocation) {
      invocation.initParams<AgeFormInitialParams>().onAgeSelected('24');
      return navigationCompleter.future;
    });
    when(() => navigator.openPhoneForm(any())).thenAnswer((invocation) {
      invocation.initParams<PhoneFormInitialParams>().onChangedPhone(
            const PhonePageResult(
              phoneVerificationData: PhoneVerificationData.empty(),
            ),
          );
      return navigationCompleter.future;
    });
    _mockCodeVerification(navigator, passedOnboarding: false);
    when(() => navigator.openUsernameForm(any())).thenAnswer((invocation) {
      invocation.initParams<UsernameFormInitialParams>().onUsernameSelected('andrzej');
      return navigationCompleter.future;
    });

    when(() => navigator.openProfilePhotoForm(any())).thenAnswer((invocation) {
      invocation.initParams<ProfilePhotoFormInitialParams>().onTapContinue('');
      return navigationCompleter.future;
    });

    when(() => navigator.openPermissionsForm(any())).thenAnswer((invocation) {
      invocation.initParams<PermissionsFormInitialParams>().onContinue(RuntimePermissionStatus.granted);
      return navigationCompleter.future;
    });

    when(() => navigator.openOnBoardingCirclesPickerPage(any())).thenAnswer((invocation) {
      invocation.initParams<OnBoardingCirclesPickerInitialParams>().onCirclesSelected([]);
      return navigationCompleter.future;
    });
    when(() => navigator.showError(any())).thenAnswer((invocation) => Future.value());
    when(
      () => navigator.openMain(any()),
    ).thenAnswer((_) => Future.value());
    when(
      () => navigator.closeAllOnboardingSteps(),
    ).thenAnswer((_) => Future.value());

    when(() => OnboardingMocks.registerUseCase.execute(formData: any(named: "formData"))).thenAnswer(
      (invocation) => successFuture(
        const PrivateProfile.empty().copyWith(user: const User.empty().copyWith(id: const Id("userId"))),
      ),
    );
    when(
      () => Mocks.getRuntimePermissionStatusUseCase.execute(permission: RuntimePermission.notifications),
    ).thenAnswer(
      (_) => successFuture(RuntimePermissionStatus.denied),
    );
    when(
      () => Mocks.getRuntimePermissionStatusUseCase.execute(permission: RuntimePermission.contacts),
    ).thenAnswer(
      (_) => successFuture(RuntimePermissionStatus.denied),
    );
  });
}

extension InvocationParams on Invocation {
  T initParams<T>() => positionalArguments.first as T;
}
