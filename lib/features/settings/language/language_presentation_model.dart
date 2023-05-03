import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/settings/language/language_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LanguagePresentationModel implements LanguageViewModel {
  /// Creates the initial state
  LanguagePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LanguageInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : languageListResult = const FutureResult.empty(),
        selectedLanguage = '',
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  LanguagePresentationModel._({
    required this.languageListResult,
    required this.selectedLanguage,
    required this.featureFlags,
  });

  final FeatureFlags featureFlags;

  @override
  final String selectedLanguage;
  final FutureResult<Either<GetLanguageFailure, List<Language>>> languageListResult;

  @override
  List<Language> get languages => languageListResult.result?.getSuccess() ?? [];

  @override
  bool get showLanguageSearchBar => featureFlags[FeatureFlagType.showLanguageSearchBar];

  LanguagePresentationModel copyWith({
    String? selectedLanguage,
    FutureResult<Either<GetLanguageFailure, List<Language>>>? languageListResult,
    FeatureFlags? featureFlags,
  }) {
    return LanguagePresentationModel._(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      languageListResult: languageListResult ?? this.languageListResult,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LanguageViewModel {
  List<Language> get languages;

  String get selectedLanguage;

  bool get showLanguageSearchBar;
}
