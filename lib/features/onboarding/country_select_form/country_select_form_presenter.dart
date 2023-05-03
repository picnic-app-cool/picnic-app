import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presentation_model.dart';

class CountrySelectFormPresenter extends Cubit<CountrySelectFormViewModel> {
  CountrySelectFormPresenter(
    CountrySelectFormPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final CountrySelectFormNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  CountrySelectFormPresentationModel get _model => state as CountrySelectFormPresentationModel;

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingCountryContinueButton),
    );
    _model.onCountrySelectedCallback(_model.countryCode);
  }

  void onChangedCountryCode(String countryCode) {
    tryEmit(_model.copyWith(countryCode: countryCode));
  }
}
