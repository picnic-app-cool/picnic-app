import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late LanguageSelectFormPresentationModel model;
  late LanguageSelectFormPresenter presenter;
  late MockLanguageSelectFormNavigator navigator;

  void _initMvp({bool languageSelected = false}) {
    model = LanguageSelectFormPresentationModel.initial(
      LanguageSelectFormInitialParams(
        onLanguageSelected: (_) {},
        formData: const OnboardingFormData.empty().copyWith(
          language: languageSelected
              ? const Language(
                  title: 'english',
                  code: 'en',
                  flag: '🇺🇸',
                )
              : const Language.empty(),
        ),
      ),
    );
    navigator = MockLanguageSelectFormNavigator();
    presenter = LanguageSelectFormPresenter(
      model,
      navigator,
      Mocks.getLanguagesListUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    when(() => Mocks.getLanguagesListUseCase.execute()).thenAnswer((_) => successFuture([const Language.empty()]));
  }

  test(
    'initially the continue button should be disabled when no language is selected',
    () {
      _initMvp();
      expect(model.isContinueEnabled, false);
      expect(presenter, isNotNull);
    },
  );

  test(
    'the continue button should be enabled when the language is selected',
    () {
      _initMvp(languageSelected: true);
      expect(model.isContinueEnabled, true);
      expect(presenter, isNotNull);
    },
  );

  test(
    'selected language should be changed when user tapped on other language',
    () {
      const otherLanguage = Language(
        title: 'wednesday',
        code: 'dudes',
        flag: '🐸',
      );
      _initMvp();

      presenter.onTapSelectLanguage(otherLanguage);

      expect(presenter.state.selectedLanguage, otherLanguage);
    },
  );
}
