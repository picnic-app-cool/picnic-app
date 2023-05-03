import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LanguageSelectFormPresentationModel implements LanguageSelectFormViewModel {
  /// Creates the initial state
  LanguageSelectFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LanguageSelectFormInitialParams initialParams,
  )   : onLanguageSelectedCallback = initialParams.onLanguageSelected,
        selectedLanguage = initialParams.formData.language,
        languageListResult = const FutureResult.empty(),
        selectedCountryCode = initialParams.formData.country;

  /// Used for the copyWith method
  LanguageSelectFormPresentationModel._({
    required this.onLanguageSelectedCallback,
    required this.selectedLanguage,
    required this.languageListResult,
    required this.selectedCountryCode,
  });

  @override
  final Language selectedLanguage;
  final ValueChanged<Language> onLanguageSelectedCallback;
  final FutureResult<Either<GetLanguageFailure, List<Language>>> languageListResult;

  final String selectedCountryCode;

  @override
  String get errorMessage => (languageListResult.result?.isFailure ?? false) //
      ? appLocalizations.languagesListFetchError
      : '';

  @override
  bool get isLoading => languageListResult.isPending();

  @override
  bool get isContinueEnabled => selectedLanguage != const Language.empty();

  @override
  List<Language> get languages => languageListResult.result?.getSuccess() ?? [];

  LanguageSelectFormPresentationModel copyWith({
    Language? selectedLanguage,
    ValueChanged<Language>? onLanguageSelectedCallback,
    FutureResult<Either<GetLanguageFailure, List<Language>>>? languageListResult,
    String? selectedCountryCode,
  }) {
    return LanguageSelectFormPresentationModel._(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      onLanguageSelectedCallback: onLanguageSelectedCallback ?? this.onLanguageSelectedCallback,
      languageListResult: languageListResult ?? this.languageListResult,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LanguageSelectFormViewModel {
  String get errorMessage;

  bool get isLoading;

  bool get isContinueEnabled;

  List<Language> get languages;

  Language get selectedLanguage;
}
