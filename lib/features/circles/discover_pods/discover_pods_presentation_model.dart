import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DiscoverPodsPresentationModel implements DiscoverPodsViewModel {
  /// Creates the initial state
  DiscoverPodsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DiscoverPodsInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        pods = const PaginatedList.empty();

  /// Used for the copyWith method
  DiscoverPodsPresentationModel._({
    required this.pods,
    required this.circleId,
  });

  @override
  final PaginatedList<CirclePodApp> pods;

  @override
  final Id circleId;

  DiscoverPodsPresentationModel copyWith({
    PaginatedList<CirclePodApp>? pods,
    Id? circleId,
  }) {
    return DiscoverPodsPresentationModel._(
      pods: pods ?? this.pods,
      circleId: circleId ?? this.circleId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DiscoverPodsViewModel {
  PaginatedList<CirclePodApp> get pods;

  Id get circleId;
}
