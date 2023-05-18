import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleElectionPresentationModel implements CircleElectionViewModel {
  /// Creates the initial state
  CircleElectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleElectionInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    this.currentTimeProvider,
  )   : candidates = const PaginatedList.empty(),
        selectedCandidate = const Selectable(item: VoteCandidate.empty()),
        seedsInCircle = 0,
        isDemocraticCircle = false,
        featureFlags = featureFlagsStore.featureFlags,
        circle = initialParams.circle,
        circleId = initialParams.circleId,
        searchQuery = '';

  /// Used for the copyWith method
  CircleElectionPresentationModel._({
    required this.candidates,
    required this.selectedCandidate,
    required this.seedsInCircle,
    required this.isDemocraticCircle,
    required this.currentTimeProvider,
    required this.circle,
    required this.featureFlags,
    required this.circleId,
    required this.searchQuery,
  });

  @override
  final PaginatedList<VoteCandidate> candidates;

  @override
  final Selectable<VoteCandidate> selectedCandidate;

  final FeatureFlags featureFlags;

  @override
  final int seedsInCircle;

  @override
  final bool isDemocraticCircle;

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final Circle circle;

  @override
  final Id circleId;

  @override
  final String searchQuery;

  //TODO BE NEEDS TO ADD THIS
  @override
  bool get eligible => true;

  @override
  bool get showCountDownWidget => featureFlags[FeatureFlagType.enableEectionCountDownWidget];

  @override
  bool get voteEnabled => eligible && selectedCandidate.item != const VoteCandidate.empty();

  @override
  bool get showCircleProgressWidget => featureFlags[FeatureFlagType.enableElectionCircularGraph];

  CircleElectionPresentationModel byAppendingCandidatesList({
    required PaginatedList<VoteCandidate> newList,
  }) =>
      copyWith(
        candidates: candidates + newList,
      );

  CircleElectionPresentationModel copyWith({
    PaginatedList<VoteCandidate>? candidates,
    Selectable<VoteCandidate>? selectedCandidate,
    FeatureFlags? featureFlags,
    int? seedsInCircle,
    bool? isDemocraticCircle,
    CurrentTimeProvider? currentTimeProvider,
    Circle? circle,
    Id? circleId,
    String? searchQuery,
  }) {
    return CircleElectionPresentationModel._(
      candidates: candidates ?? this.candidates,
      selectedCandidate: selectedCandidate ?? this.selectedCandidate,
      featureFlags: featureFlags ?? this.featureFlags,
      seedsInCircle: seedsInCircle ?? this.seedsInCircle,
      isDemocraticCircle: isDemocraticCircle ?? this.isDemocraticCircle,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      circle: circle ?? this.circle,
      circleId: circleId ?? this.circleId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleElectionViewModel {
  PaginatedList<VoteCandidate> get candidates;

  Selectable<VoteCandidate> get selectedCandidate;

  int get seedsInCircle;

  bool get isDemocraticCircle;

  CurrentTimeProvider get currentTimeProvider;

  Id get circleId;

  Circle get circle;

  bool get showCircleProgressWidget;

  bool get eligible;

  bool get voteEnabled;

  bool get showCountDownWidget;

  String get searchQuery;
}
