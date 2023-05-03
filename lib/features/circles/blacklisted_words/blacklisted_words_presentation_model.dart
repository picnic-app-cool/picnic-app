import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/get_blacklisted_words_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class BlacklistedWordsPresentationModel implements BlacklistedWordsViewModel {
  /// Creates the initial state
  BlacklistedWordsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    BlacklistedWordsInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : words = const PaginatedList.empty(),
        searchQuery = '',
        circleId = initialParams.circleId,
        featureFlags = featureFlagsStore.featureFlags,
        getWordsOperation = null;

  /// Used for the copyWith method
  BlacklistedWordsPresentationModel._({
    required this.words,
    required this.searchQuery,
    required this.circleId,
    required this.featureFlags,
    required this.getWordsOperation,
  });

  final FeatureFlags featureFlags;

  @override
  final Id circleId;

  @override
  final PaginatedList<String> words;

  @override
  final String searchQuery;

  final CancelableOperation<Either<GetBlacklistedWordsFailure, PaginatedList<String>>>? getWordsOperation;

  @override
  bool get searchBlacklistWordsEnabled => featureFlags[FeatureFlagType.searchBlacklistWordsEnabled];

  Cursor get cursor => words.nextPageCursor();

  BlacklistedWordsPresentationModel byAppendingWords(PaginatedList<String> newItems) => copyWith(
        words: words + newItems,
      );

  BlacklistedWordsPresentationModel byRemovingWord(String item) => copyWith(
        words: words.byRemoving(element: item),
      );

  BlacklistedWordsPresentationModel copyWith({
    PaginatedList<String>? words,
    String? searchQuery,
    Id? circleId,
    FeatureFlags? featureFlags,
    CancelableOperation<Either<GetBlacklistedWordsFailure, PaginatedList<String>>>? getWordsOperation,
  }) {
    return BlacklistedWordsPresentationModel._(
      words: words ?? this.words,
      searchQuery: searchQuery ?? this.searchQuery,
      circleId: circleId ?? this.circleId,
      featureFlags: featureFlags ?? this.featureFlags,
      getWordsOperation: getWordsOperation ?? this.getWordsOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class BlacklistedWordsViewModel {
  PaginatedList<String> get words;

  String get searchQuery;

  Id get circleId;

  bool get searchBlacklistWordsEnabled;
}
