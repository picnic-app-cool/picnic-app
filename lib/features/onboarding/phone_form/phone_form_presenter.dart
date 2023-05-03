//ignore_for_file: forbidden_import_in_presentation
import 'package:bloc/bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_operation_result.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/apple_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/discord_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/google_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/log_in_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_code_for_username_login_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_phone_code_use_case.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';

class PhoneFormPresenter extends Cubit<PhoneFormViewModel> {
  PhoneFormPresenter(
    PhoneFormPresentationModel model,
    this.navigator,
    this._requestPhoneCodeUseCase,
    this._logInUseCase,
    this._logAnalyticsEventUseCase,
    this._requestCodeForUsenameLoginUseCase,
  ) : super(model);

  final PhoneFormNavigator navigator;
  final RequestPhoneCodeUseCase _requestPhoneCodeUseCase;
  final LogInUseCase _logInUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final RequestCodeForUsernameLoginUseCase _requestCodeForUsenameLoginUseCase;

  // ignore: unused_element
  PhoneFormPresentationModel get _model => state as PhoneFormPresentationModel;

  void onInit() {
    tryEmit(
      _model.copyWith(isUsernameAuthOpened: !_model.isFirebasePhoneAuthEnabled),
    );
  }

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.onboardingPhoneContinueButton,
      ),
    );
    if (_model.isUsernameAuthOpened) {
      _requestUsernameCode();
    } else {
      _requestPhoneCode();
    }
  }

  void onChangedPhone(String value) => tryEmit(
        _model.byUpdatingVerificationData(
          (data) => data.copyWith(phoneNumber: value),
        ),
      );

  void onChangeUsername(String username) => tryEmit(
        _model.copyWith(username: username),
      );

  void onEnableUsernameLogin({required bool isEnabled}) => tryEmit(
        _model.copyWith(isUsernameAuthOpened: isEnabled),
      );

  Future<void> onTapGoogleLogIn() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingSignUpGoogle),
    );
    await _logIn(const GoogleLogInCredentials());
  }

  Future<void> onTapAppleLogIn() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingSignUpApple),
    );

    await _logIn(const AppleLogInCredentials());
  }

  Future<void> onTapDiscordLogIn() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingSignUpDiscord),
    );

    const _customUriScheme = "https";

    //TODO: remove from here and put in env variables
    final url = Uri.https(
      'discord.com',
      '/api/oauth2/authorize',
      {
        'client_id': '1100738037777956954',
        'redirect_uri': 'https://picnic.zone/login',
        'strictDiscoveryDocumentValidation': 'false',
        'grant_type': 'authorization_code',
        'oidc': 'false',
        'response_type': 'code',
        'disablePKCE': 'true',
        'scope': 'identify',
      },
    );

    final result = await FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: _customUriScheme,
    );

    var urlCode = Uri.parse(result);
    var code = urlCode.queryParameters['code'] ?? "";

    await _logIn(DiscordLogInCredentials(code));

    _model.onDiscordCallback?.call();
  }

  void onChangedDialCode(String? dialCode) => tryEmit(
        _model.byUpdatingVerificationData(
          (data) => data.copyWith(dialCode: dialCode),
        ),
      );

  void onTapTerms() => navigator.openUrl(Constants.termsUrl);

  void onTapPolicies() => navigator.openUrl(Constants.policiesUrl);

  Future<void> _logIn(LogInCredentials credentials) => _logInUseCase
          .execute(credentials) //
          .observeStatusChanges(
            (result) => tryEmit(_model.copyWith(socialLoginFutureResult: result)),
          )
          .doOn(
        fail: (fail) {
          _logLoginAnalytics(type: credentials.type, success: false);

          if (fail.type == LogInFailureType.canceled) {
            return;
          } else if (fail.type == LogInFailureType.userNotFound) {
            //this indicates that sign in has succeeded, but the user does not exist, so we should
            // trigger onboarding flow (and sign up eventually at the end)
            _model.onChangedPhoneCallback(
              PhonePageResult(authResult: fail.toAuthResult()),
            );
          } else {
            navigator.showError(fail.displayableFailure());
          }
        },
        success: (authResult) {
          _logLoginAnalytics(type: credentials.type, success: true);

          _model.onChangedPhoneCallback(
            PhonePageResult(authResult: authResult),
          );
        },
      );

  void _logLoginAnalytics({required LogInType type, required bool success}) {
    final result = success ? AnalyticsOperationResult.success : AnalyticsOperationResult.failure;
    _logAnalyticsEventUseCase.execute(AnalyticsEvent.login(logInType: type, result: result));
  }

  Future<void> _requestPhoneCode() => _requestPhoneCodeUseCase
      .execute(verificationData: _model.verificationData) //
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(phoneCodeFutureResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (verificationData) {
          tryEmit(_model.copyWith(verificationData: verificationData));
          _model.onChangedPhoneCallback(
            PhonePageResult(phoneVerificationData: _model.verificationData),
          );
        },
      );

  Future<void> _requestUsernameCode() => _requestCodeForUsenameLoginUseCase
      .execute(username: _model.username)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(usernameCodeFutureResult: result)),
      )
      .doOn(
        success: (verificationData) {
          tryEmit(_model.copyWith(usernameVerificationData: verificationData));
          _model.onChangedPhoneCallback(
            PhonePageResult(usernameVerificationData: _model.usernameVerificationData),
          );
        },
        fail: (failure) => navigator.showError(failure.displayableFailure()),
      );
}
