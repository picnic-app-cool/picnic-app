import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';

class GenderSelectFormPresenter extends Cubit<GenderSelectFormViewModel> {
  GenderSelectFormPresenter(
    GenderSelectFormPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final GenderSelectFormNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  GenderSelectFormPresentationModel get _model => state as GenderSelectFormPresentationModel;

  void onTapSelectGender(String gender) {
    tryEmit(_model.copyWith(selectedGender: gender));
  }

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.onboardingLanguageContinueButton,
      ),
    );
    _model.onGenderSelectedCallback(_model.selectedGender);
  }
}
