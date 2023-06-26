import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_operation_result.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_navigator.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/log_in_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_code_for_username_login_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_phone_code_use_case.dart';

class CodeVerificationFormPresenter extends Cubit<CodeVerificationFormViewModel> {
  CodeVerificationFormPresenter(
    CodeVerificationFormPresentationModel model,
    this.navigator,
    this._logInUseCase,
    this._requestPhoneCodeUseCase,
    this._logAnalyticsEventUseCase,
    this._requestCodeForUsernameLoginUseCase,
    this._throttler,
  ) : super(model);

  final CodeVerificationFormNavigator navigator;
  final LogInUseCase _logInUseCase;
  final Throttler _throttler;
  final RequestPhoneCodeUseCase _requestPhoneCodeUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final RequestCodeForUsernameLoginUseCase _requestCodeForUsernameLoginUseCase;

  // ignore: unused_element
  CodeVerificationFormPresentationModel get _model => state as CodeVerificationFormPresentationModel;

  Future<void> onChangedCode(String value) async {
    if (value == _model.code) {
      return;
    }

    await _verifyCode(value);
  }

  Future<void> onTapContinue() async {
    await _verifyCode(_model.code);
  }

  Future<void> onTapResendCode() => _model.isUsernameLogin ? _requestUsernameCode() : _requestPhoneCode();

  Future<void> _verifyCode(String value) async {
    if (_model.isUsernameLogin) {
      tryEmit(
        _model.copyWith(
          usernameVerificationData: _model.usernameVerificationData.copyWith(code: value),
        ),
      );
    } else {
      tryEmit(
        _model.copyWith(
          verificationData: _model.verificationData.copyWith(smsCode: value),
        ),
      );
    }
    if (!_model.isLoading) {
      tryEmit(_model.copyWith(codeVerificationResult: const FutureResult.empty()));
    }
    if (_model.isCodeLengthValid) {
      await _validateCode();
    }
  }

  Future<void>? _validateCode() => _throttler.throttle(const LongDuration(), () async {
        final credentials = _model.logInCredentials;
        if (_model.isLoading) {
          return;
        }
        await _logInUseCase.execute(credentials).observeStatusChanges((result) {
          tryEmit(_model.copyWith(codeVerificationResult: result));
        }).doOn(
          fail: (fail) {
            _logAnalyticsEventUseCase.execute(
              AnalyticsEvent.login(logInType: credentials.type, result: AnalyticsOperationResult.failure),
            );
            if (fail.type == LogInFailureType.userNotFound) {
              //this indicates that sign in has succeeded, but the user does not exist, so we should
              // trigger onboarding flow (and sign up eventually at the end)
              _model.onCodeVerifiedCallback(
                fail.toAuthResult(),
              );
            } else if (fail.type != LogInFailureType.invalidCode) {
              navigator.showError(fail.displayableFailure());
            }
          },
          success: (authResult) {
            _logAnalyticsEventUseCase.execute(
              AnalyticsEvent.login(logInType: credentials.type, result: AnalyticsOperationResult.success),
            );
            _model.onCodeVerifiedCallback(authResult);
          },
        );
      });

  Future<void> _requestPhoneCode() => _requestPhoneCodeUseCase
      .execute(verificationData: _model.verificationData)
      .observeStatusChanges((result) => tryEmit(_model.copyWith(requestCodeResult: result)))
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (verificationData) => tryEmit(
          _model.byResettingTimer(
            verificationData: verificationData,
            usernameVerificationData: _model.usernameVerificationData,
          ),
        ),
      );

  Future<void> _requestUsernameCode() => _requestCodeForUsernameLoginUseCase
      .execute(username: _model.usernameVerificationData.username)
      .observeStatusChanges((result) => tryEmit(_model.copyWith(requestUsernameCodeResult: result)))
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (verificationData) => tryEmit(
          _model.byResettingTimer(
            verificationData: _model.verificationData,
            usernameVerificationData: _model.usernameVerificationData,
          ),
        ),
      );
}
