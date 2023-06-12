import 'package:picnic_app/core/domain/use_cases/check_username_availability_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_languages_list_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_navigator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_page.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_page.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_navigator.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_page.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_page.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_captcha_params_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_groups_with_circles_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_onboarding_circles_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/log_in_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/register_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_code_for_username_login_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_phone_code_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/sign_in_with_username_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/validators/onboarding_form_validator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_page.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_page.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_navigator.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_page.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presenter.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_page.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presenter.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_navigator.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_page.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presenter.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_page.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_navigator.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_page.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presenter.dart';
import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';
import 'package:picnic_app/features/onboarding/splash/splash_navigator.dart';
import 'package:picnic_app/features/onboarding/splash/splash_page.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presenter.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_navigator.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_page.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presenter.dart';
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

//ignore: long-method
void _configureGeneralDependencies() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<OnboardingFormValidator>(
          () => OnboardingFormValidator(),
        )
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<CheckUsernameAvailabilityUseCase>(
          () => CheckUsernameAvailabilityUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetLanguagesListUseCase>(
          () => GetLanguagesListUseCase(getIt()),
        )
        ..registerFactory<GetGroupsWithCirclesUseCase>(
          () => GetGroupsWithCirclesUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetOnBoardingCirclesUseCase>(
          () => GetOnBoardingCirclesUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RequestPhoneCodeUseCase>(
          () => RequestPhoneCodeUseCase(
            getIt(),
          ),
        )
        ..registerFactory<LogInUseCase>(
          () => LogInUseCase(
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<RegisterUseCase>(
          () => RegisterUseCase(
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<SaveAuthTokenUseCase>(
          () => SaveAuthTokenUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetAuthTokenUseCase>(
          () => GetAuthTokenUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCaptchaParamsUseCase>(
          () => GetCaptchaParamsUseCase(getIt()),
        )
        ..registerFactory<SignInWithUsernameUseCase>(
          () => SignInWithUsernameUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RequestCodeForUsernameLoginUseCase>(
          () => RequestCodeForUsernameLoginUseCase(
            getIt(),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG

      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<SplashNavigator>(
          () => SplashNavigator(getIt()),
        )
        ..registerFactoryParam<SplashPresentationModel, SplashInitialParams, dynamic>(
          (params, _) => SplashPresentationModel.initial(params),
        )
        ..registerFactoryParam<SplashPresenter, SplashInitialParams, dynamic>(
          (initialParams, _) => SplashPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SplashPage, SplashInitialParams, dynamic>(
          (initialParams, _) => SplashPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<UsernameFormNavigator>(
          () => UsernameFormNavigator(getIt()),
        )
        ..registerFactoryParam<UsernameFormPresentationModel, UsernameFormInitialParams, dynamic>(
          (params, _) => UsernameFormPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<UsernameFormPresenter, UsernameFormInitialParams, dynamic>(
          (initialParams, _) => UsernameFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<UsernameFormPage, UsernameFormInitialParams, dynamic>(
          (initialParams, _) => UsernameFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactoryParam<OnboardingPresentationModel, OnboardingInitialParams, dynamic>(
          (params, _) => OnboardingPresentationModel.initial(params),
        )
        ..registerFactory<OnboardingNavigator>(
          () => OnboardingNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<OnboardingPresenter, OnboardingInitialParams, dynamic>(
          (initialParams, _) => OnboardingPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<OnboardingPage, OnboardingInitialParams, dynamic>(
          (initialParams, _) => OnboardingPage(
            presenter: getIt(param1: initialParams),
            navigatorKey: getIt(), // TODO verify this
          ),
        )
        ..registerFactory<AgeFormNavigator>(
          () => AgeFormNavigator(getIt()),
        )
        ..registerFactoryParam<AgeFormPresentationModel, AgeFormInitialParams, dynamic>(
          (params, _) => AgeFormPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<AgeFormPresenter, AgeFormInitialParams, dynamic>(
          (initialParams, _) => AgeFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<AgeFormPage, AgeFormInitialParams, dynamic>(
          (initialParams, _) => AgeFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<MethodFormNavigator>(
          () => MethodFormNavigator(getIt()),
        )
        ..registerFactoryParam<MethodFormPresentationModel, MethodFormInitialParams, dynamic>(
          (params, _) => MethodFormPresentationModel.initial(
            params,
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<MethodFormPresenter, MethodFormInitialParams, dynamic>(
          (initialParams, _) => MethodFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<MethodFormPage, MethodFormInitialParams, dynamic>(
          (initialParams, _) => MethodFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CodeVerificationFormNavigator>(
          () => CodeVerificationFormNavigator(getIt()),
        )
        ..registerFactoryParam<CodeVerificationFormPresentationModel, CodeVerificationFormInitialParams, dynamic>(
          (params, _) => CodeVerificationFormPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CodeVerificationFormPresenter, CodeVerificationFormInitialParams, dynamic>(
          (initialParams, _) => CodeVerificationFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CodeVerificationFormPage, CodeVerificationFormInitialParams, dynamic>(
          (initialParams, _) => CodeVerificationFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<LanguageSelectFormNavigator>(
          () => LanguageSelectFormNavigator(getIt()),
        )
        ..registerFactoryParam<LanguageSelectFormPresentationModel, LanguageSelectFormInitialParams, dynamic>(
          (params, _) => LanguageSelectFormPresentationModel.initial(params),
        )
        ..registerFactoryParam<LanguageSelectFormPresenter, LanguageSelectFormInitialParams, dynamic>(
          (initialParams, _) => LanguageSelectFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<LanguageSelectFormPage, LanguageSelectFormInitialParams, dynamic>(
          (initialParams, _) => LanguageSelectFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<GenderSelectFormNavigator>(
          () => GenderSelectFormNavigator(getIt()),
        )
        ..registerFactoryParam<GenderSelectFormPresentationModel, GenderSelectFormInitialParams, dynamic>(
          (params, _) => GenderSelectFormPresentationModel.initial(params),
        )
        ..registerFactoryParam<GenderSelectFormPresenter, GenderSelectFormInitialParams, dynamic>(
          (initialParams, _) => GenderSelectFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<GenderSelectFormPage, GenderSelectFormInitialParams, dynamic>(
          (initialParams, _) => GenderSelectFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<ProfilePhotoFormNavigator>(
          () => ProfilePhotoFormNavigator(getIt()),
        )
        ..registerFactoryParam<ProfilePhotoFormPresentationModel, ProfilePhotoFormInitialParams, dynamic>(
          (params, _) => ProfilePhotoFormPresentationModel.initial(params),
        )
        ..registerFactoryParam<ProfilePhotoFormPresenter, ProfilePhotoFormInitialParams, dynamic>(
          (initialParams, _) => ProfilePhotoFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ProfilePhotoFormPage, ProfilePhotoFormInitialParams, dynamic>(
          (initialParams, _) => ProfilePhotoFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PermissionsFormNavigator>(
          () => PermissionsFormNavigator(getIt()),
        )
        ..registerFactoryParam<PermissionsFormPresentationModel, PermissionsFormInitialParams, dynamic>(
          (params, _) => PermissionsFormPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<PermissionsFormPresenter, PermissionsFormInitialParams, dynamic>(
          (initialParams, _) => PermissionsFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PermissionsFormPage, PermissionsFormInitialParams, dynamic>(
          (initialParams, _) => PermissionsFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PhoneFormNavigator>(
          () => PhoneFormNavigator(getIt()),
        )
        ..registerFactoryParam<PhoneFormPresentationModel, PhoneFormInitialParams, dynamic>(
          (params, _) => PhoneFormPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<PhoneFormPresenter, PhoneFormInitialParams, dynamic>(
          (initialParams, _) => PhoneFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PhoneFormPage, PhoneFormInitialParams, dynamic>(
          (initialParams, _) => PhoneFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<OnBoardingCirclesPickerNavigator>(
          () => OnBoardingCirclesPickerNavigator(),
        )
        ..registerFactoryParam<OnBoardingCirclesPickerPresentationModel, OnBoardingCirclesPickerInitialParams, dynamic>(
          (params, _) => OnBoardingCirclesPickerPresentationModel.initial(params),
        )
        ..registerFactoryParam<OnBoardingCirclesPickerPresenter, OnBoardingCirclesPickerInitialParams, dynamic>(
          (initialParams, _) => OnBoardingCirclesPickerPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<OnboardingCirclesPickerPage, OnBoardingCirclesPickerInitialParams, dynamic>(
          (initialParams, _) => OnboardingCirclesPickerPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CountrySelectFormNavigator>(
          () => CountrySelectFormNavigator(getIt()),
        )
        ..registerFactoryParam<CountrySelectFormPresentationModel, CountrySelectFormInitialParams, dynamic>(
          (params, _) => CountrySelectFormPresentationModel.initial(params),
        )
        ..registerFactoryParam<CountrySelectFormPresenter, CountrySelectFormInitialParams, dynamic>(
          (initialParams, _) => CountrySelectFormPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CountrySelectFormPage, CountrySelectFormInitialParams, dynamic>(
          (initialParams, _) => CountrySelectFormPage(
            presenter: getIt(param1: initialParams),
          ),
        )
      //DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
