import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';

class FeatureFlagsStore extends Cubit<FeatureFlags> {
  FeatureFlagsStore({
    FeatureFlags? featureFlags,
    required FeatureFlagsDefaults featureFlagsDefaults,
  }) : super(featureFlags ?? FeatureFlags.defaultFlags(featureFlagsDefaults));

  FeatureFlags get featureFlags => state;

  set featureFlags(FeatureFlags featureFlags) {
    tryEmit(featureFlags);
  }
}
