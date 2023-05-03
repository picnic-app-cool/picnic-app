import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/apple_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/google_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mock_definitions.dart';
import 'onboarding_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class OnboardingMocks {
  // MVP

  static late MockOnboardingPresenter onboardingPresenter;
  static late MockOnboardingPresentationModel onboardingPresentationModel;
  static late MockOnboardingInitialParams onboardingInitialParams;
  static late MockOnboardingNavigator onboardingNavigator;
  static late MockSplashPresenter splashPresenter;
  static late MockSplashPresentationModel splashPresentationModel;
  static late MockSplashInitialParams splashInitialParams;
  static late MockSplashNavigator splashNavigator;
  static late MockUsernameFormPresenter usernameFormPresenter;
  static late MockUsernameFormPresentationModel usernameFormPresentationModel;
  static late MockUsernameFormInitialParams usernameFormInitialParams;
  static late MockUsernameFormNavigator usernameFormNavigator;
  static late MockAgeFormPresenter ageFormPresenter;
  static late MockAgeFormPresentationModel ageFormPresentationModel;
  static late MockAgeFormInitialParams ageFormInitialParams;
  static late MockAgeFormNavigator ageFormNavigator;

  static late MockPhoneFormPresenter phoneFormPresenter;
  static late MockPhoneFormPresentationModel phoneFormPresentationModel;
  static late MockPhoneFormInitialParams phoneFormInitialParams;
  static late MockPhoneFormNavigator phoneFormNavigator;
  static late MockCodeVerificationFormPresenter codeVerificationFormPresenter;
  static late MockCodeVerificationFormPresentationModel codeVerificationFormPresentationModel;
  static late MockCodeVerificationFormInitialParams codeVerificationFormInitialParams;
  static late MockCodeVerificationFormNavigator codeVerificationFormNavigator;

  static late MockProfilePhotoFormPresenter profilePhotoFormPresenter;
  static late MockProfilePhotoFormPresentationModel profilePhotoFormPresentationModel;
  static late MockProfilePhotoFormInitialParams profilePhotoFormInitialParams;
  static late MockProfilePhotoFormNavigator profilePhotoFormNavigator;
  static late MockPermissionsFormPresenter permissionsFormPresenter;
  static late MockPermissionsFormPresentationModel permissionsFormPresentationModel;
  static late MockPermissionsFormInitialParams permissionsFormInitialParams;
  static late MockPermissionsFormNavigator permissionsFormNavigator;
  static late MockCongratsFormPresenter congratsFormPresenter;
  static late MockCongratsFormPresentationModel congratsFormPresentationModel;
  static late MockCongratsFormInitialParams congratsFormInitialParams;
  static late MockCongratsFormNavigator congratsFormNavigator;
  static late MockOnBoardingCirclesPickerPresenter circleGroupingsFormPresenter;
  static late MockOnBoardingCirclesPickerPresentationModel circleGroupingsFormPresentationModel;
  static late MockOnBoardingCirclesPickerInitialParams circleGroupingsFormInitialParams;
  static late MockOnBoardingCirclesPickerNavigator circleGroupingsFormNavigator;

  static late MockCountrySelectFormPresenter countrySelectFormPresenter;
  static late MockCountrySelectFormPresentationModel countrySelectFormPresentationModel;
  static late MockCountrySelectFormInitialParams countrySelectFormInitialParams;
  static late MockCountrySelectFormNavigator countrySelectFormNavigator;

  static late MockLanguageSelectFormPresenter languageSelectFormPresenter;
  static late MockLanguageSelectFormPresentationModel languageSelectFormPresentationModel;
  static late MockLanguageSelectFormInitialParams languageSelectFormInitialParams;
  static late MockLanguageSelectFormNavigator languageSelectFormNavigator;
  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetGroupsOfCirclesFailure getCircleGroupingsFailure;
  static late MockGetCircleGroupingsUseCase getCircleGroupingsUseCase;
  static late MockGetOnBoardingCirclesUseCase getOnBoardingCirclesUseCase;
  static late MockRequestPhoneCodeFailure requestPhoneCodeFailure;
  static late MockRequestPhoneCodeUseCase requestPhoneCodeUseCase;

  static late MockLogInFailure logInFailure;
  static late MockLogInUseCase logInUseCase;

  static late MockRegisterFailure registerFailure;
  static late MockRegisterUseCase registerUseCase;

  static late MockSaveAuthTokenFailure saveAuthTokenFailure;
  static late MockSaveAuthTokenUseCase saveAuthTokenUseCase;
  static late MockGetCaptchaParamsFailure getCaptchaParamsFailure;
  static late MockGetCaptchaParamsUseCase getCaptchaParamsUseCase;

  static late MockSignInWithUsernameFailure signInWithUsernameFailure;
  static late MockSignInWithUsernameUseCase signInWithUsernameUseCase;

  static late MockRequestCodeForUsernameLoginFailure requestCodeForUsernameLoginFailure;
  static late MockRequestCodeForUsernameLoginUseCase requestCodeForUsernameLoginUseCase;

  // REPOSITORIES
  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    splashPresenter = MockSplashPresenter();
    splashPresentationModel = MockSplashPresentationModel();
    splashInitialParams = MockSplashInitialParams();
    splashNavigator = MockSplashNavigator();
    ageFormPresenter = MockAgeFormPresenter();
    ageFormPresentationModel = MockAgeFormPresentationModel();
    ageFormInitialParams = MockAgeFormInitialParams();
    ageFormNavigator = MockAgeFormNavigator();
    usernameFormPresenter = MockUsernameFormPresenter();
    usernameFormPresentationModel = MockUsernameFormPresentationModel();
    usernameFormInitialParams = MockUsernameFormInitialParams();
    usernameFormNavigator = MockUsernameFormNavigator();
    onboardingPresenter = MockOnboardingPresenter();
    onboardingPresentationModel = MockOnboardingPresentationModel();
    onboardingInitialParams = MockOnboardingInitialParams();
    onboardingNavigator = MockOnboardingNavigator();
    languageSelectFormPresenter = MockLanguageSelectFormPresenter();
    languageSelectFormPresentationModel = MockLanguageSelectFormPresentationModel();
    languageSelectFormInitialParams = MockLanguageSelectFormInitialParams();
    languageSelectFormNavigator = MockLanguageSelectFormNavigator();
    phoneFormPresenter = MockPhoneFormPresenter();
    phoneFormPresentationModel = MockPhoneFormPresentationModel();
    phoneFormInitialParams = MockPhoneFormInitialParams();
    phoneFormNavigator = MockPhoneFormNavigator();
    codeVerificationFormPresenter = MockCodeVerificationFormPresenter();
    codeVerificationFormPresentationModel = MockCodeVerificationFormPresentationModel();
    codeVerificationFormInitialParams = MockCodeVerificationFormInitialParams();
    codeVerificationFormNavigator = MockCodeVerificationFormNavigator();
    profilePhotoFormPresenter = MockProfilePhotoFormPresenter();
    profilePhotoFormPresentationModel = MockProfilePhotoFormPresentationModel();
    profilePhotoFormInitialParams = MockProfilePhotoFormInitialParams();
    profilePhotoFormNavigator = MockProfilePhotoFormNavigator();
    permissionsFormPresenter = MockPermissionsFormPresenter();
    permissionsFormPresentationModel = MockPermissionsFormPresentationModel();
    permissionsFormInitialParams = MockPermissionsFormInitialParams();
    permissionsFormNavigator = MockPermissionsFormNavigator();
    congratsFormPresenter = MockCongratsFormPresenter();
    congratsFormPresentationModel = MockCongratsFormPresentationModel();
    congratsFormInitialParams = MockCongratsFormInitialParams();
    congratsFormNavigator = MockCongratsFormNavigator();
    circleGroupingsFormPresenter = MockOnBoardingCirclesPickerPresenter();
    circleGroupingsFormPresentationModel = MockOnBoardingCirclesPickerPresentationModel();
    circleGroupingsFormInitialParams = MockOnBoardingCirclesPickerInitialParams();
    circleGroupingsFormNavigator = MockOnBoardingCirclesPickerNavigator();
    countrySelectFormPresenter = MockCountrySelectFormPresenter();
    countrySelectFormPresentationModel = MockCountrySelectFormPresentationModel();
    countrySelectFormInitialParams = MockCountrySelectFormInitialParams();
    countrySelectFormNavigator = MockCountrySelectFormNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getCircleGroupingsFailure = MockGetGroupsOfCirclesFailure();
    getCircleGroupingsUseCase = MockGetCircleGroupingsUseCase();
    getOnBoardingCirclesUseCase = MockGetOnBoardingCirclesUseCase();
    requestPhoneCodeFailure = MockRequestPhoneCodeFailure();
    requestPhoneCodeUseCase = MockRequestPhoneCodeUseCase();
    logInFailure = MockLogInFailure();
    logInUseCase = MockLogInUseCase();
    registerFailure = MockRegisterFailure();
    registerUseCase = MockRegisterUseCase();
    saveAuthTokenFailure = MockSaveAuthTokenFailure();
    saveAuthTokenUseCase = MockSaveAuthTokenUseCase();
    getCaptchaParamsFailure = MockGetCaptchaParamsFailure();
    getCaptchaParamsUseCase = MockGetCaptchaParamsUseCase();

    signInWithUsernameFailure = MockSignInWithUsernameFailure();
    signInWithUsernameUseCase = MockSignInWithUsernameUseCase();

    requestCodeForUsernameLoginFailure = MockRequestCodeForUsernameLoginFailure();
    requestCodeForUsernameLoginUseCase = MockRequestCodeForUsernameLoginUseCase();

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockSplashPresenter());
    registerFallbackValue(MockSplashPresentationModel());
    registerFallbackValue(MockSplashInitialParams());
    registerFallbackValue(MockSplashNavigator());
    registerFallbackValue(MockAgeFormPresenter());
    registerFallbackValue(MockAgeFormPresentationModel());
    registerFallbackValue(MockAgeFormInitialParams());
    registerFallbackValue(MockAgeFormNavigator());
    registerFallbackValue(MockUsernameFormPresenter());
    registerFallbackValue(MockUsernameFormPresentationModel());
    registerFallbackValue(MockUsernameFormInitialParams());
    registerFallbackValue(MockUsernameFormNavigator());
    registerFallbackValue(MockOnboardingPresenter());
    registerFallbackValue(MockOnboardingPresentationModel());
    registerFallbackValue(MockOnboardingInitialParams());
    registerFallbackValue(MockOnboardingNavigator());
    registerFallbackValue(MockPhoneFormPresenter());
    registerFallbackValue(MockPhoneFormPresentationModel());
    registerFallbackValue(MockPhoneFormInitialParams());
    registerFallbackValue(MockPhoneFormNavigator());
    registerFallbackValue(MockCodeVerificationFormPresenter());
    registerFallbackValue(MockCodeVerificationFormPresentationModel());
    registerFallbackValue(MockCodeVerificationFormInitialParams());
    registerFallbackValue(MockCodeVerificationFormNavigator());
    registerFallbackValue(MockProfilePhotoFormPresenter());
    registerFallbackValue(MockProfilePhotoFormPresentationModel());
    registerFallbackValue(MockProfilePhotoFormInitialParams());
    registerFallbackValue(MockProfilePhotoFormNavigator());
    registerFallbackValue(MockPermissionsFormPresenter());
    registerFallbackValue(MockPermissionsFormPresentationModel());
    registerFallbackValue(MockPermissionsFormInitialParams());
    registerFallbackValue(MockPermissionsFormNavigator());
    registerFallbackValue(MockCongratsFormPresenter());
    registerFallbackValue(MockCongratsFormPresentationModel());
    registerFallbackValue(MockCongratsFormInitialParams());
    registerFallbackValue(MockCongratsFormNavigator());
    registerFallbackValue(MockOnBoardingCirclesPickerPresenter());
    registerFallbackValue(MockOnBoardingCirclesPickerPresentationModel());
    registerFallbackValue(MockOnBoardingCirclesPickerInitialParams());
    registerFallbackValue(MockOnBoardingCirclesPickerNavigator());
    registerFallbackValue(MockCountrySelectFormPresenter());
    registerFallbackValue(MockCountrySelectFormPresentationModel());
    registerFallbackValue(MockCountrySelectFormInitialParams());
    registerFallbackValue(MockCountrySelectFormNavigator());
    registerFallbackValue(MockLanguageSelectFormPresenter());
    registerFallbackValue(MockLanguageSelectFormPresentationModel());
    registerFallbackValue(MockLanguageSelectFormInitialParams());
    registerFallbackValue(MockLanguageSelectFormNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetGroupsOfCirclesFailure());
    registerFallbackValue(MockGetCircleGroupingsUseCase());
    registerFallbackValue(MockGetOnBoardingCirclesUseCase());
    registerFallbackValue(MockRequestPhoneCodeFailure());
    registerFallbackValue(MockRequestPhoneCodeUseCase());
    registerFallbackValue(MockLogInFailure());
    registerFallbackValue(MockLogInUseCase());
    registerFallbackValue(MockRegisterFailure());
    registerFallbackValue(MockRegisterUseCase());

    registerFallbackValue(MockSaveAuthTokenFailure());
    registerFallbackValue(MockSaveAuthTokenUseCase());
    registerFallbackValue(MockGetCaptchaParamsFailure());
    registerFallbackValue(MockGetCaptchaParamsUseCase());
    registerFallbackValue(MockGetAuthTokenFailure());
    registerFallbackValue(MockGetAuthTokenUseCase());

    registerFallbackValue(MockSignInWithUsernameFailure());
    registerFallbackValue(MockSignInWithUsernameUseCase());

    registerFallbackValue(MockRequestCodeForUsernameLoginFailure());
    registerFallbackValue(MockRequestCodeForUsernameLoginUseCase());

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
    registerFallbackValue(const OnboardingFormData.empty());
    registerFallbackValue(const GoogleLogInCredentials());
    registerFallbackValue(const AppleLogInCredentials());
    registerFallbackValue(const PhoneLogInCredentials(PhoneVerificationData.empty()));
  }
}
