import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DiscoverExplorePresentationModel implements DiscoverExploreViewModel {
  /// Creates the initial state
  DiscoverExplorePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DiscoverExploreInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : feedGroups = <CircleGroup>[],
        popularFeedPosts = <Post>[],
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  DiscoverExplorePresentationModel._({
    required this.feedGroups,
    required this.popularFeedPosts,
    required this.featureFlags,
  });

  final FeatureFlags featureFlags;

  @override
  final List<CircleGroup> feedGroups;

  @override
  final List<Post> popularFeedPosts;

  @override
  bool get areTrendingPostsEnabled => featureFlags[FeatureFlagType.areTrendingPostsEnabled];

  DiscoverExplorePresentationModel copyWith({
    List<CircleGroup>? feedGroups,
    List<Post>? popularFeedPosts,
    FeatureFlags? featureFlags,
  }) {
    return DiscoverExplorePresentationModel._(
      feedGroups: feedGroups ?? this.feedGroups,
      popularFeedPosts: popularFeedPosts ?? this.popularFeedPosts,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DiscoverExploreViewModel {
  List<CircleGroup> get feedGroups;

  List<Post> get popularFeedPosts;

  bool get areTrendingPostsEnabled;
}
