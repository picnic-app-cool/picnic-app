import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FeatureFlagsPresentationModel implements FeatureFlagsViewModel {
  /// Creates the initial state
  FeatureFlagsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FeatureFlagsInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  ) : internalFeatureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  FeatureFlagsPresentationModel._({required this.internalFeatureFlags});

  final FeatureFlags internalFeatureFlags;

  @override
  List<MapEntry<FeatureFlagType, bool>> get featureFlags =>
      internalFeatureFlags.flags.keys.map((key) => MapEntry(key, internalFeatureFlags[key])).toList();

  FeatureFlagsPresentationModel copyWith({FeatureFlags? featureFlags}) {
    return FeatureFlagsPresentationModel._(
      internalFeatureFlags: featureFlags ?? internalFeatureFlags,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FeatureFlagsViewModel {
  List<MapEntry<FeatureFlagType, bool>> get featureFlags;
}
