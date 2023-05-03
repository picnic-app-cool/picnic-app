import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_navigator.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presentation_model.dart';

class CongratsFormPresenter extends Cubit<CongratsFormViewModel> {
  CongratsFormPresenter(
    CongratsFormPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final CongratsFormNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  CongratsFormPresentationModel get _model => state as CongratsFormPresentationModel;

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingWelcomeContinueButton),
    );
    _model.onTapContinueCallback();
  }
}
