import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/ban_type.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class BanUserPresentationModel implements BanUserViewModel {
  /// Creates the initial state
  BanUserPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    BanUserInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : user = initialParams.user,
        circleId = initialParams.circleId,
        selectedBanType = BanType.permanent,
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  BanUserPresentationModel._({
    required this.featureFlags,
    required this.user,
    required this.circleId,
    required this.selectedBanType,
  });

  @override
  final MinimalPublicProfile user;

  @override
  final Id circleId;

  @override
  final BanType selectedBanType;

  final FeatureFlags featureFlags;

  @override
  bool get enableTempBan => featureFlags[FeatureFlagType.tempBanEnabled];

  @override
  List<BanType> get choices => [
        BanType.permanent,
        if (enableTempBan) BanType.temporary,
      ];

  BanUserPresentationModel copyWith({
    MinimalPublicProfile? user,
    BanType? selectedBanType,
    Id? circleId,
    FeatureFlags? featureFlags,
  }) {
    return BanUserPresentationModel._(
      user: user ?? this.user,
      selectedBanType: selectedBanType ?? this.selectedBanType,
      circleId: circleId ?? this.circleId,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class BanUserViewModel {
  MinimalPublicProfile get user;

  Id get circleId;

  List<BanType> get choices;

  BanType get selectedBanType;

  bool get enableTempBan;
}
