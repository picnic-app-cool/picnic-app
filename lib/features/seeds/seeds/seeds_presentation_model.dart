import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SeedsPresentationModel implements SeedsViewModel {
  /// Creates the initial state
  SeedsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SeedsInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : seeds = const PaginatedList.empty(),
        isBlurred = false,
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  SeedsPresentationModel._({
    required this.seeds,
    required this.isBlurred,
    required this.featureFlags,
  });

  final FeatureFlags featureFlags;

  @override
  final PaginatedList<Seed> seeds;

  @override
  final bool isBlurred;

  @override
  bool get showSendSeedsButton => featureFlags[FeatureFlagType.seedsProfileCircleEnabled];

  SeedsPresentationModel byAppendingSeedsList(PaginatedList<Seed> seedsList) => copyWith(seeds: seeds + seedsList);

  SeedsPresentationModel copyWith({
    PaginatedList<Seed>? seeds,
    bool? isBlurred,
    FeatureFlags? featureFlags,
  }) =>
      SeedsPresentationModel._(
        seeds: seeds ?? this.seeds,
        isBlurred: isBlurred ?? this.isBlurred,
        featureFlags: featureFlags ?? this.featureFlags,
      );
}

/// Interface to expose fields used by the view (page).
abstract class SeedsViewModel {
  PaginatedList<Seed> get seeds;

  bool get isBlurred;

  bool get showSendSeedsButton;
}
