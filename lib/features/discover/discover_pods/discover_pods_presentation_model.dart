import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DiscoverPodsPresentationModel implements DiscoverPodsViewModel {
  /// Creates the initial state
  DiscoverPodsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DiscoverPodsInitialParams initialParams,
  )   : newPods = const PaginatedList.empty(),
        featuredPods = const PaginatedList.empty(),
        trendingPods = const PaginatedList.empty();

  /// Used for the copyWith method
  DiscoverPodsPresentationModel._({
    required this.trendingPods,
    required this.newPods,
    required this.featuredPods,
  });

  @override
  final PaginatedList<PodApp> featuredPods;

  @override
  final PaginatedList<PodApp> trendingPods;

  @override
  final PaginatedList<PodApp> newPods;

  @override
  List<String> get cats => [
        'moderation',
        'anime',
        'fun',
        'funny',
        'art',
        'chat',
        'game',
        'gaming',
        'genshin impact',
        'gacha',
        'roblox',
        'roleplay',
        'social',
        'utility',
        'kpop',
        'meme',
        'music',
        'writing',
      ];

  DiscoverPodsPresentationModel byAppendingFeaturedPodsList({
    required PaginatedList<PodApp> newList,
  }) =>
      copyWith(
        featuredPods: featuredPods + newList,
      );

  DiscoverPodsPresentationModel byAppendingTrendingPodsList({
    required PaginatedList<PodApp> newList,
  }) =>
      copyWith(
        trendingPods: trendingPods + newList,
      );

  DiscoverPodsPresentationModel byAppendingNewPodsList({
    required PaginatedList<PodApp> newList,
  }) =>
      copyWith(
        newPods: newPods + newList,
      );

  List<PodApp> bySavingTrendingPod({
    required Id podId,
  }) {
    return trendingPods.items
        .map(
          (pod) => pod.id == podId ? pod.copyWith(iSaved: true) : pod,
        )
        .toList();
  }

  List<PodApp> bySavingNewPod({
    required Id podId,
  }) {
    return newPods.items
        .map(
          (pod) => pod.id == podId ? pod.copyWith(iSaved: true) : pod,
        )
        .toList();
  }

  List<PodApp> bySavingFeaturedPod({
    required Id podId,
  }) {
    return featuredPods.items
        .map(
          (pod) => pod.id == podId ? pod.copyWith(iSaved: true) : pod,
        )
        .toList();
  }

  List<PodApp> byVotingTrendingPod({
    required PodApp podApp,
  }) =>
      trendingPods.items
          .map(
            (pod) => pod.id == podApp.id ? podApp : pod,
          )
          .toList();

  List<PodApp> byVotingNewPod({
    required PodApp podApp,
  }) =>
      trendingPods.items
          .map(
            (pod) => pod.id == podApp.id ? podApp : pod,
          )
          .toList();

  List<PodApp> byVotingFeaturedPod({
    required PodApp podApp,
  }) =>
      trendingPods.items
          .map(
            (pod) => pod.id == podApp.id ? podApp : pod,
          )
          .toList();

  DiscoverPodsPresentationModel copyWith({
    PaginatedList<PodApp>? trendingPods,
    PaginatedList<PodApp>? newPods,
    PaginatedList<PodApp>? featuredPods,
  }) {
    return DiscoverPodsPresentationModel._(
      trendingPods: trendingPods ?? this.trendingPods,
      newPods: newPods ?? this.newPods,
      featuredPods: featuredPods ?? this.featuredPods,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DiscoverPodsViewModel {
  List<String> get cats;

  PaginatedList<PodApp> get trendingPods;

  PaginatedList<PodApp> get newPods;

  PaginatedList<PodApp> get featuredPods;
}
