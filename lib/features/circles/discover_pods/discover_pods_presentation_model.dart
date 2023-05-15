import 'package:picnic_app/core/domain/model/app_owner.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
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

  @override
  PaginatedList<CirclePodApp> get mockedPodsList => PaginatedList.singlePage(
        [
          const CirclePodApp.empty().copyWith(
            app: const PodApp.empty().copyWith(
              id: const Id('1'),
              name: 'ai-image-generator',
              description: 'Pod 1 description',
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/3095/a20b/654aae02f1c4c15b348c9933ad523f38?Expires=1684713600&Signature=SpmyOdy7Zo~gmihMda9YLnCJGrirS1DxjTKBcZAjx6CedNqc74kHLNC0E68clvT3xkPN39iLXY7xMyrXSQjXkfp7~loOz~eLaO96iTLJaBQiep7bMna5icRfy5ZA3I2WrCk0Mb1MUvd9GphE~mnbw4Jq1pu2oc3CTKUhUbsHsK48sgDmbb7yJM2hhFe~2NUnzHGXnudCWdPCrTcFWplgctUpXuk4hPshPz3eNzxG4yEeGRjzVCLYp~gvI6G1cymkyA0LxDcAiHWGNeEvGBHXsio2KRXVUBmG79TLUq-budgXfn6e~y98TutREDZpL7p82k992DdkF~giCHc8~YFn6Q__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
              url: 'https://pods.picnic.zone/ai-image-generator/',
              owner: const AppOwner(
                id: Id('1'),
                name: 'picnic dev team',
              ),
            ),
          ),
        ],
      );

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

  PaginatedList<CirclePodApp> get mockedPodsList;

  Id get circleId;
}
