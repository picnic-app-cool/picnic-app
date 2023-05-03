import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/use_cases/get_languages_list_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_navigator.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';

class LanguageSelectFormPresenter extends Cubit<LanguageSelectFormViewModel> {
  LanguageSelectFormPresenter(
    LanguageSelectFormPresentationModel model,
    this.navigator,
    this._getLanguagesUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final LanguageSelectFormNavigator navigator;
  final GetLanguagesListUseCase _getLanguagesUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  LanguageSelectFormPresentationModel get _model => state as LanguageSelectFormPresentationModel;

  Future<void> onInit() async => getLanguages();

  void onTapSelectLanguage(Language language) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.onboardingLanguageSelectButton,
        targetValue: language.code,
      ),
    );
    tryEmit(_model.copyWith(selectedLanguage: language));
  }

  void onTapContinue() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.onboardingLanguageContinueButton,
      ),
    );
    _model.onLanguageSelectedCallback(_model.selectedLanguage);
  }

  void getLanguages() => _getLanguagesUseCase
          .execute() //
          .observeStatusChanges(
        (result) {
          tryEmit(_model.copyWith(languageListResult: result));
        },
      ).doOn(
        success: (languages) => tryEmit(
          _model.copyWith(
            selectedLanguage: languages.firstWhereOrNull(
              (it) => it.code == _model.selectedCountryCode,
            ),
          ),
        ),
      );
}
