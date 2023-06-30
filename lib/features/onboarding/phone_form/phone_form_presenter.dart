import 'package:bloc/bloc.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/country_with_dial_code.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/request_phone_code_use_case.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_navigator.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';

class PhoneFormPresenter extends Cubit<CongratsFormViewModel> {
  PhoneFormPresenter(
    PhoneFormPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
    this._requestPhoneCodeUseCase,
  ) : super(model);

  final PhoneFormNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final RequestPhoneCodeUseCase _requestPhoneCodeUseCase;

  // ignore: unused_element
  PhoneFormPresentationModel get _model => state as PhoneFormPresentationModel;

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.onboardingPhoneContinueButton,
      ),
    );
    _requestPhoneCode();
  }

  void onChangedCountry(CountryWithDialCode country) => tryEmit(
        _model.byUpdatingVerificationData(
          (data) => data.copyWith(
            country: country,
          ),
        ),
      );

  void onChangedPhone(String value) {
    tryEmit(
      _model.byUpdatingVerificationData(
        (data) => data.copyWith(phoneNumber: value),
      ),
    );
  }

  Future<void> onTapCountryCode() async {
    await navigator.showCountryCodePickerBottomSheet(
      countriesList: _model.countriesList,
      onTapCountry: onChangedCountry,
    );
  }

  void onTapTerms() => navigator.openUrl(Constants.termsUrl);

  void onTapPolicies() => navigator.openUrl(Constants.policiesUrl);

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
}
