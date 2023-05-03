import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';

/// holds info about feature flags that denote what features should be available and which should not
class FeatureFlags extends Equatable {
  const FeatureFlags({
    required Map<FeatureFlagType, bool> flags,
    required FeatureFlagsDefaults featureFlagsDefauls,
  })  : _flags = flags,
        _featureFlagsDefauls = featureFlagsDefauls;

  const FeatureFlags.empty()
      : _flags = const {},
        _featureFlagsDefauls = const FeatureFlagsDefaults.empty();

  factory FeatureFlags.defaultFlags(FeatureFlagsDefaults featureFlagsDefaults) {
    final flags = FeatureFlagType.values
        .asMap() //
        .map((key, value) => MapEntry(value, featureFlagsDefaults.defaultState(value)));

    return FeatureFlags(
      flags: flags,
      featureFlagsDefauls: featureFlagsDefaults,
    );
  }

  final Map<FeatureFlagType, bool> _flags;
  final FeatureFlagsDefaults _featureFlagsDefauls;

  Map<FeatureFlagType, bool> get flags => Map.fromEntries(
        FeatureFlagType.values.map(
          (e) => MapEntry(e, get(e)),
        ),
      );

  @override
  List<Object?> get props => [flags, _featureFlagsDefauls];

  bool operator [](FeatureFlagType key) => get(key);

  bool get(FeatureFlagType key) => _flags[key] ?? _featureFlagsDefauls.defaultState(key);

  FeatureFlags copyWith({
    Map<FeatureFlagType, bool>? flags,
  }) {
    return FeatureFlags(
      flags: flags ?? this.flags,
      featureFlagsDefauls: _featureFlagsDefauls,
    );
  }
}
