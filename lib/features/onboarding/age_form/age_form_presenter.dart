import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_navigator.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';

class AgeFormPresenter extends Cubit<AgeFormViewModel> {
  AgeFormPresenter(
    AgeFormPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final AgeFormNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  AgeFormPresentationModel get _model => state as AgeFormPresentationModel;

  void onChangedAge(String value) => tryEmit(_model.copyWith(ageText: value));

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingAgeContinueButton),
    );
    _model.onAgeSelectedCallback(_model.ageText);
  }
}
