import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LanguagesListPresentationModel implements LanguagesListViewModel {
  /// Creates the initial state
  LanguagesListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LanguagesListInitialParams initialParams,
  )   : languagesListResult = const FutureResult.empty(),
        selectedLanguage = initialParams.selectedLanguage;

  /// Used for the copyWith method
  LanguagesListPresentationModel._({
    required this.languagesListResult,
    required this.selectedLanguage,
  });

  final FutureResult<Either<GetLanguageFailure, List<Language>>> languagesListResult;

  @override
  final Language selectedLanguage;

  @override
  List<Language> get languages => languagesListResult.getSuccess() ?? List.empty();

  @override
  bool get isLoading => languagesListResult.isPending();

  LanguagesListPresentationModel copyWith({
    FutureResult<Either<GetLanguageFailure, List<Language>>>? languagesListResult,
    Language? selectedLanguage,
  }) {
    return LanguagesListPresentationModel._(
      languagesListResult: languagesListResult ?? this.languagesListResult,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LanguagesListViewModel {
  List<Language> get languages;

  bool get isLoading;

  Language get selectedLanguage;
}
