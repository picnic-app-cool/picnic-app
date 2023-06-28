import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/save_auth_token_failure.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/features/circles/domain/model/get_groups_of_circles_failure.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_navigator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_navigator.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_captcha_params_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_circles_for_interests_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_code_for_username_login_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/sign_in_with_username_failure.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_captcha_params_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_circles_for_interests_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_groups_with_circles_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_onboarding_circles_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_onboarding_interests_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/log_in_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/register_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_code_for_username_login_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_phone_code_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/sign_in_with_username_use_case.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_navigator.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presenter.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presenter.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_navigator.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presenter.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_navigator.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presenter.dart';
import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';
import 'package:picnic_app/features/onboarding/splash/splash_navigator.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presenter.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_navigator.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockOnboardingPresenter extends MockCubit<OnboardingViewModel> implements OnboardingPresenter {}

class MockOnboardingPresentationModel extends Mock implements OnboardingPresentationModel {}

class MockOnboardingInitialParams extends Mock implements OnboardingInitialParams {}

class MockOnboardingNavigator extends Mock implements OnboardingNavigator {}

class MockSplashPresenter extends Mock implements SplashPresenter {}

class MockSplashPresentationModel extends Mock implements SplashPresentationModel {}

class MockSplashInitialParams extends Mock implements SplashInitialParams {}

class MockSplashNavigator extends Mock implements SplashNavigator {}

class MockAgeFormPresenter extends MockCubit<AgeFormViewModel> implements AgeFormPresenter {}

class MockAgeFormPresentationModel extends Mock implements AgeFormPresentationModel {}

class MockAgeFormInitialParams extends Mock implements AgeFormInitialParams {}

class MockAgeFormNavigator extends Mock implements AgeFormNavigator {}

class MockUsernameFormPresenter extends MockCubit<UsernameFormViewModel> implements UsernameFormPresenter {}

class MockUsernameFormPresentationModel extends Mock implements UsernameFormPresentationModel {}

class MockUsernameFormInitialParams extends Mock implements UsernameFormInitialParams {}

class MockUsernameFormNavigator extends Mock implements UsernameFormNavigator {}

class MockMethodFormPresenter extends MockCubit<MethodFormViewModel> implements MethodFormPresenter {}

class MockMethodFormPresentationModel extends Mock implements MethodFormPresentationModel {}

class MockMethodFormInitialParams extends Mock implements MethodFormInitialParams {}

class MockMethodFormNavigator extends Mock implements MethodFormNavigator {}

class MockCodeVerificationFormPresenter extends MockCubit<CodeVerificationFormViewModel>
    implements CodeVerificationFormPresenter {}

class MockCodeVerificationFormPresentationModel extends Mock implements CodeVerificationFormPresentationModel {}

class MockCodeVerificationFormInitialParams extends Mock implements CodeVerificationFormInitialParams {}

class MockCodeVerificationFormNavigator extends Mock implements CodeVerificationFormNavigator {}

class MockProfilePhotoFormPresenter extends MockCubit<ProfilePhotoFormViewModel> implements ProfilePhotoFormPresenter {}

class MockProfilePhotoFormPresentationModel extends Mock implements ProfilePhotoFormPresentationModel {}

class MockProfilePhotoFormInitialParams extends Mock implements ProfilePhotoFormInitialParams {}

class MockProfilePhotoFormNavigator extends Mock implements ProfilePhotoFormNavigator {}

class MockPermissionsFormPresenter extends MockCubit<PermissionsFormViewModel> implements PermissionsFormPresenter {}

class MockPermissionsFormPresentationModel extends Mock implements PermissionsFormPresentationModel {}

class MockPermissionsFormInitialParams extends Mock implements PermissionsFormInitialParams {}

class MockPermissionsFormNavigator extends Mock implements PermissionsFormNavigator {}

class MockPhoneFormPresenter extends MockCubit<CongratsFormViewModel> implements PhoneFormPresenter {}

class MockPhoneFormPresentationModel extends Mock implements PhoneFormPresentationModel {}

class MockPhoneFormInitialParams extends Mock implements PhoneFormInitialParams {}

class MockPhoneFormNavigator extends Mock implements PhoneFormNavigator {}

class MockOnBoardingCirclesPickerPresenter extends MockCubit<OnBoardingCirclesPickerViewModel>
    implements OnBoardingCirclesPickerPresenter {}

class MockOnBoardingCirclesPickerPresentationModel extends Mock implements OnBoardingCirclesPickerPresentationModel {}

class MockOnBoardingCirclesPickerInitialParams extends Mock implements OnBoardingCirclesPickerInitialParams {}

class MockOnBoardingCirclesPickerNavigator extends Mock implements OnBoardingCirclesPickerNavigator {}

class MockCountrySelectFormPresenter extends MockCubit<CountrySelectFormViewModel>
    implements CountrySelectFormPresenter {}

class MockCountrySelectFormPresentationModel extends Mock implements CountrySelectFormPresentationModel {}

class MockCountrySelectFormInitialParams extends Mock implements CountrySelectFormInitialParams {}

class MockCountrySelectFormNavigator extends Mock implements CountrySelectFormNavigator {}

class MockLanguageSelectFormPresenter extends MockCubit<LanguageSelectFormViewModel>
    implements LanguageSelectFormPresenter {}

class MockLanguageSelectFormPresentationModel extends Mock implements LanguageSelectFormPresentationModel {}

class MockLanguageSelectFormInitialParams extends Mock implements LanguageSelectFormInitialParams {}

class MockLanguageSelectFormNavigator extends Mock implements LanguageSelectFormNavigator {}

class MockGenderSelectFormPresenter extends MockCubit<GenderSelectFormViewModel> implements GenderSelectFormPresenter {}

class MockGenderSelectFormPresentationModel extends Mock implements GenderSelectFormPresentationModel {}

class MockGenderSelectFormInitialParams extends Mock implements GenderSelectFormInitialParams {}

class MockGenderSelectFormNavigator extends Mock implements GenderSelectFormNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetGroupsOfCirclesFailure extends Mock implements GetGroupsOfCirclesFailure {}

class MockGetCircleGroupingsUseCase extends Mock implements GetGroupsWithCirclesUseCase {}

class MockGetOnBoardingCirclesUseCase extends Mock implements GetOnBoardingCirclesUseCase {}

class MockGetOnBoardingInterestsUseCase extends Mock implements GetOnBoardingInterestsUseCase {}

class MockRequestPhoneCodeFailure extends Mock implements RequestPhoneCodeFailure {}

class MockRequestPhoneCodeUseCase extends Mock implements RequestPhoneCodeUseCase {}

class MockLogInFailure extends Mock implements LogInFailure {}

class MockLogInUseCase extends Mock implements LogInUseCase {}

class MockRegisterFailure extends Mock implements RegisterFailure {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockSaveAuthTokenFailure extends Mock implements SaveAuthTokenFailure {}

class MockSaveAuthTokenUseCase extends Mock implements SaveAuthTokenUseCase {}

class MockGetCaptchaParamsFailure extends Mock implements GetCaptchaParamsFailure {}

class MockGetCaptchaParamsUseCase extends Mock implements GetCaptchaParamsUseCase {}

class MockSignInWithUsernameFailure extends Mock implements SignInWithUsernameFailure {}

class MockSignInWithUsernameUseCase extends Mock implements SignInWithUsernameUseCase {}

class MockRequestCodeForUsernameLoginFailure extends Mock implements RequestCodeForUsernameLoginFailure {}

class MockRequestCodeForUsernameLoginUseCase extends Mock implements RequestCodeForUsernameLoginUseCase {}

class MockGetCirclesForInterestsFailure extends Mock implements GetCirclesForInterestsFailure {}

class MockGetCirclesForInterestsUseCase extends Mock implements GetCirclesForInterestsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
