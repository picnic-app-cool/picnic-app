import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DiscoverSearchResultsPresentationModel implements DiscoverSearchResultsViewModel {
  /// Creates the initial state
  DiscoverSearchResultsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DiscoverSearchResultsInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : query = '',
        circles = [],
        users = [],
        isCirclesLoading = false,
        isUsersLoading = false,
        featureFlags = featureFlagsStore.featureFlags,
        followResult = const FutureResult.empty();

  /// Used for the copyWith method
  DiscoverSearchResultsPresentationModel._({
    required this.query,
    required this.circles,
    required this.users,
    required this.isCirclesLoading,
    required this.isUsersLoading,
    required this.featureFlags,
    required this.followResult,
  });

  final FeatureFlags featureFlags;

  final String query;

  final bool isCirclesLoading;

  final bool isUsersLoading;

  @override
  final List<Circle> circles;

  @override
  final List<PublicProfile> users;

  @override
  final FutureResult<void> followResult;

  @override
  bool get isLoading => isCirclesLoading || isUsersLoading;

  @override
  bool get isInitial => query.isEmpty || circles.isEmpty && users.isEmpty;

  @override
  bool get followButtonOnDiscoverPageResultsEnabled =>
      featureFlags[FeatureFlagType.followButtonOnDiscoverPageResultsEnabled];

  @override
  bool get isLoadingToggleFollow => followResult.isPending();

  DiscoverSearchResultsPresentationModel byUpdateFollowAction(PublicProfile follower) => copyWith(
        users: users.byUpdatingItem(
          update: (update) {
            return update.copyWith(iFollow: !update.iFollow);
          },
          itemFinder: (finder) => follower.id == finder.id,
        ),
      );

  DiscoverSearchResultsPresentationModel copyWith({
    String? query,
    List<Circle>? circles,
    List<PublicProfile>? users,
    bool? isLoading,
    bool? isCirclesLoading,
    bool? isUsersLoading,
    FeatureFlags? featureFlags,
    FutureResult<void>? followResult,
  }) =>
      DiscoverSearchResultsPresentationModel._(
        query: query ?? this.query,
        circles: circles ?? this.circles,
        users: users ?? this.users,
        isCirclesLoading: isCirclesLoading ?? this.isCirclesLoading,
        isUsersLoading: isUsersLoading ?? this.isUsersLoading,
        featureFlags: featureFlags ?? this.featureFlags,
        followResult: followResult ?? this.followResult,
      );
}

/// Interface to expose fields used by the view (page).
abstract class DiscoverSearchResultsViewModel {
  bool get isLoading;

  bool get isInitial;

  List<Circle> get circles;

  List<PublicProfile> get users;

  bool get followButtonOnDiscoverPageResultsEnabled;

  FutureResult<void> get followResult;

  bool get isLoadingToggleFollow;
}
