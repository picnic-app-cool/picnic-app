import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FeaturesIndexPresentationModel implements FeaturesIndexViewModel {
  /// Creates the initial state
  FeaturesIndexPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FeaturesIndexInitialParams initialParams,
    UserStore userStore,
  ) : user = userStore.privateProfile;

  /// Used for the copyWith method
  FeaturesIndexPresentationModel._({
    required this.user,
  });

  @override
  final PrivateProfile user;

  FeaturesIndexPresentationModel copyWith({
    PrivateProfile? user,
  }) {
    return FeaturesIndexPresentationModel._(
      user: user ?? this.user,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FeaturesIndexViewModel {
  PrivateProfile get user;
}
