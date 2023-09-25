//ignore_for_file: forbidden_import_in_presentation
import 'package:bloc/bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
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
import 'package:picnic_app/features/onboarding/method_form/method_form_navigator.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';

class MethodFormPresenter extends Cubit<MethodFormViewModel> {
  MethodFormPresenter(
    MethodFormPresentationModel model,
    this.navigator,
    this._logInUseCase,
    this._logAnalyticsEventUseCase,
    this._envConfigProvider,
  ) : super(model);

  final MethodFormNavigator navigator;
  final LogInUseCase _logInUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final EnvironmentConfigProvider _envConfigProvider;

  // ignore: unused_element
  MethodFormPresentationModel get _model => state as MethodFormPresentationModel;

  void onInit() {
    tryEmit(
      _model.copyWith(isUsernameAuthOpened: !_model.isFirebasePhoneAuthEnabled),
    );
  }

  void onTapLogin() {
    _logAnalyticsEventUseCase.execute(AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingLoginButton));
    tryEmit(
      _model.copyWith(formType: OnboardingFlowType.signIn),
    );
    _model.onTapLoginCallback.call();
  }

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.onboardingPhoneContinueButton,
      ),
    );
    _model.onPhoneCallback.call();
  }

  void onTapUsernameSignIn() {
    _model.onPhoneCallback.call();
  }

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

    final env = await _envConfigProvider.getConfig();

    //TODO: remove from here and put in env variables
    final url = Uri.https(
      'discord.com',
      '/api/oauth2/authorize',
      {
        'client_id': env.discordClientId,
        'redirect_uri': env.discordRedirectUrl,
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
}
