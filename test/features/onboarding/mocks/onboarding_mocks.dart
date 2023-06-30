import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/apple_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/google_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/gender.dart';
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

  static late MockMethodFormPresenter methodFormPresenter;
  static late MockMethodFormPresentationModel methodFormPresentationModel;
  static late MockMethodFormInitialParams methodFormInitialParams;
  static late MockMethodFormNavigator methodFormNavigator;
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
  static late MockPhoneFormPresenter phoneFormPresenter;
  static late MockPhoneFormPresentationModel phoneFormPresentationModel;
  static late MockPhoneFormInitialParams phoneFormInitialParams;
  static late MockPhoneFormNavigator phoneFormNavigator;
  static late MockOnBoardingCirclesPickerPresenter circleGroupingsFormPresenter;
  static late MockOnBoardingCirclesPickerPresentationModel circleGroupingsFormPresentationModel;
  static late MockOnBoardingCirclesPickerInitialParams circleGroupingsFormInitialParams;
  static late MockOnBoardingCirclesPickerNavigator circleGroupingsFormNavigator;

  static late MockLanguageSelectFormPresenter languageSelectFormPresenter;
  static late MockLanguageSelectFormPresentationModel languageSelectFormPresentationModel;
  static late MockLanguageSelectFormInitialParams languageSelectFormInitialParams;
  static late MockLanguageSelectFormNavigator languageSelectFormNavigator;

  static late MockGenderSelectFormPresenter genderSelectFormPresenter;
  static late MockGenderSelectFormPresentationModel genderSelectFormPresentationModel;
  static late MockGenderSelectFormInitialParams genderSelectFormInitialParams;
  static late MockGenderSelectFormNavigator genderSelectFormNavigator;

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetGroupsOfCirclesFailure getCircleGroupingsFailure;
  static late MockGetCircleGroupingsUseCase getCircleGroupingsUseCase;
  static late MockGetOnBoardingCirclesUseCase getOnBoardingCirclesUseCase;
  static late MockGetOnBoardingInterestsUseCase getOnBoardingInterestsUseCase;
  static late MockGetCirclesForInterestsUseCase getCirclesForInterestsUseCase;
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

  static late MockGetCirclesForInterestsFailure getCirclesForInterestsFailure;

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

    genderSelectFormPresenter = MockGenderSelectFormPresenter();
    genderSelectFormPresentationModel = MockGenderSelectFormPresentationModel();
    genderSelectFormInitialParams = MockGenderSelectFormInitialParams();
    genderSelectFormNavigator = MockGenderSelectFormNavigator();

    methodFormPresenter = MockMethodFormPresenter();
    methodFormPresentationModel = MockMethodFormPresentationModel();
    methodFormInitialParams = MockMethodFormInitialParams();
    methodFormNavigator = MockMethodFormNavigator();
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
    phoneFormPresenter = MockPhoneFormPresenter();
    phoneFormPresentationModel = MockPhoneFormPresentationModel();
    phoneFormInitialParams = MockPhoneFormInitialParams();
    phoneFormNavigator = MockPhoneFormNavigator();
    circleGroupingsFormPresenter = MockOnBoardingCirclesPickerPresenter();
    circleGroupingsFormPresentationModel = MockOnBoardingCirclesPickerPresentationModel();
    circleGroupingsFormInitialParams = MockOnBoardingCirclesPickerInitialParams();
    circleGroupingsFormNavigator = MockOnBoardingCirclesPickerNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getCircleGroupingsFailure = MockGetGroupsOfCirclesFailure();
    getCircleGroupingsUseCase = MockGetCircleGroupingsUseCase();
    getOnBoardingCirclesUseCase = MockGetOnBoardingCirclesUseCase();
    getOnBoardingInterestsUseCase = MockGetOnBoardingInterestsUseCase();
    getCirclesForInterestsUseCase = MockGetCirclesForInterestsUseCase();
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

    getCirclesForInterestsFailure = MockGetCirclesForInterestsFailure();

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
    registerFallbackValue(MockMethodFormPresenter());
    registerFallbackValue(MockMethodFormPresentationModel());
    registerFallbackValue(MockMethodFormInitialParams());
    registerFallbackValue(MockMethodFormNavigator());
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
    registerFallbackValue(MockPhoneFormPresenter());
    registerFallbackValue(MockPhoneFormPresentationModel());
    registerFallbackValue(MockPhoneFormInitialParams());
    registerFallbackValue(MockPhoneFormNavigator());
    registerFallbackValue(MockOnBoardingCirclesPickerPresenter());
    registerFallbackValue(MockOnBoardingCirclesPickerPresentationModel());
    registerFallbackValue(MockOnBoardingCirclesPickerInitialParams());
    registerFallbackValue(MockOnBoardingCirclesPickerNavigator());
    registerFallbackValue(MockLanguageSelectFormPresenter());
    registerFallbackValue(MockLanguageSelectFormPresentationModel());
    registerFallbackValue(MockLanguageSelectFormInitialParams());
    registerFallbackValue(MockLanguageSelectFormNavigator());

    registerFallbackValue(MockGenderSelectFormPresenter());
    registerFallbackValue(MockGenderSelectFormPresentationModel());
    registerFallbackValue(MockGenderSelectFormInitialParams());
    registerFallbackValue(MockGenderSelectFormNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetGroupsOfCirclesFailure());
    registerFallbackValue(MockGetCircleGroupingsUseCase());
    registerFallbackValue(MockGetOnBoardingCirclesUseCase());
    registerFallbackValue(MockGetOnBoardingInterestsUseCase());
    registerFallbackValue(MockGetCirclesForInterestsUseCase());
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

    registerFallbackValue(MockGetCirclesForInterestsFailure());

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
    registerFallbackValue(const OnboardingFormData.empty());
    registerFallbackValue(const GoogleLogInCredentials());
    registerFallbackValue(const AppleLogInCredentials());
    registerFallbackValue(const PhoneLogInCredentials(PhoneVerificationData.empty()));
    registerFallbackValue(Gender.female);
  }
}
