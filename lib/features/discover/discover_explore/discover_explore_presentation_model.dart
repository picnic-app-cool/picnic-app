import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
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
        pods = const PaginatedList.empty(),
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  DiscoverExplorePresentationModel._({
    required this.feedGroups,
    required this.popularFeedPosts,
    required this.featureFlags,
    required this.pods,
  });

  final FeatureFlags featureFlags;

  @override
  final List<CircleGroup> feedGroups;

  @override
  final List<Post> popularFeedPosts;

  @override
  final PaginatedList<CirclePodApp> pods;

  @override
  bool get areTrendingPostsEnabled => featureFlags[FeatureFlagType.areTrendingPostsEnabled];

  @override
  bool get isLoading => trendingCircles.isEmpty || feedGroups.isEmpty;

  @override
  List<Circle> get trendingCircles => feedGroups.map((e) => e.topCircles).expand((e) => e).toList();

  DiscoverExplorePresentationModel byAppendingPodsList({
    required PaginatedList<CirclePodApp> newList,
  }) =>
      copyWith(
        pods: pods + newList,
      );

  List<CirclePodApp> bySavingPod({
    required Id podId,
  }) =>
      pods.items
          .map(
            (pod) => pod.app.id == podId ? pod.copyWith(app: pod.app.copyWith(iSaved: true)) : pod,
          )
          .toList();

  List<CirclePodApp> byVotingPod({
    required PodApp podApp,
  }) =>
      pods.items
          .map(
            (pod) => pod.app.id == podApp.id
                ? pod.copyWith(
                    app: podApp,
                  )
                : pod,
          )
          .toList();

  DiscoverExplorePresentationModel copyWith({
    List<CircleGroup>? feedGroups,
    List<Post>? popularFeedPosts,
    FeatureFlags? featureFlags,
    PaginatedList<CirclePodApp>? pods,
  }) {
    return DiscoverExplorePresentationModel._(
      feedGroups: feedGroups ?? this.feedGroups,
      popularFeedPosts: popularFeedPosts ?? this.popularFeedPosts,
      featureFlags: featureFlags ?? this.featureFlags,
      pods: pods ?? this.pods,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DiscoverExploreViewModel {
  List<CircleGroup> get feedGroups;

  List<Post> get popularFeedPosts;

  bool get areTrendingPostsEnabled;

  PaginatedList<CirclePodApp> get pods;

  List<Circle> get trendingCircles;

  bool get isLoading;
}
