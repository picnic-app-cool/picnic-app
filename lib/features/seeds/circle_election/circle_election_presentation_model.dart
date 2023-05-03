import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/model/election.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleElectionPresentationModel implements CircleElectionViewModel {
  /// Creates the initial state
  CircleElectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleElectionInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    this.currentTimeProvider,
  )   : candidates = const PaginatedList.empty(),
        selectedCandidate = const Selectable(item: ElectionCandidate.empty()),
        seedsInCircle = 0,
        isDemocraticCircle = false,
        election = const Election.empty(),
        featureFlags = featureFlagsStore.featureFlags,
        circle = initialParams.circle,
        circleId = initialParams.circleId;

  /// Used for the copyWith method
  CircleElectionPresentationModel._({
    required this.candidates,
    required this.selectedCandidate,
    required this.seedsInCircle,
    required this.isDemocraticCircle,
    required this.currentTimeProvider,
    required this.election,
    required this.circle,
    required this.featureFlags,
    required this.circleId,
  });

  @override
  final PaginatedList<ElectionCandidate> candidates;

  @override
  final Selectable<ElectionCandidate> selectedCandidate;

  final FeatureFlags featureFlags;

  @override
  final int seedsInCircle;

  @override
  final bool isDemocraticCircle;

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final Election election;

  @override
  final Circle circle;

  @override
  final Id circleId;

  @override
  bool get voted => election.iVoted;

  @override
  bool get eligible => election.isSeedHolder;

  @override
  bool get showCountDownWidget => featureFlags[FeatureFlagType.enableEectionCountDownWidget];

  @override
  bool get voteEnabled => eligible && selectedCandidate.item != const ElectionCandidate.empty();

  @override
  double get electionProgress =>
      election.maxSeedsVoted == 0 ? 0 : election.seedsVoted / election.maxSeedsVoted.toDouble();

  @override
  int get seedsVoted => election.seedsVoted;

  @override
  bool get showCircleProgressWidget => featureFlags[FeatureFlagType.enableElectionCircularGraph];

  @override
  DateTime? get deadline => election.dueToFormat;

  CircleElectionPresentationModel byAppendingCandidatesList({
    required PaginatedList<ElectionCandidate> newList,
  }) =>
      copyWith(
        candidates: candidates + newList,
      );

  CircleElectionPresentationModel copyWith({
    PaginatedList<ElectionCandidate>? candidates,
    Selectable<ElectionCandidate>? selectedCandidate,
    FeatureFlags? featureFlags,
    int? seedsInCircle,
    bool? isDemocraticCircle,
    CurrentTimeProvider? currentTimeProvider,
    Election? election,
    Circle? circle,
    Id? circleId,
  }) {
    return CircleElectionPresentationModel._(
      candidates: candidates ?? this.candidates,
      selectedCandidate: selectedCandidate ?? this.selectedCandidate,
      featureFlags: featureFlags ?? this.featureFlags,
      seedsInCircle: seedsInCircle ?? this.seedsInCircle,
      isDemocraticCircle: isDemocraticCircle ?? this.isDemocraticCircle,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      election: election ?? this.election,
      circle: circle ?? this.circle,
      circleId: circleId ?? this.circleId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleElectionViewModel {
  PaginatedList<ElectionCandidate> get candidates;

  Selectable<ElectionCandidate> get selectedCandidate;

  bool get voted;

  int get seedsInCircle;

  bool get isDemocraticCircle;

  CurrentTimeProvider get currentTimeProvider;

  DateTime? get deadline;

  Election get election;

  double get electionProgress;

  int get seedsVoted;

  Id get circleId;

  Circle get circle;

  bool get showCircleProgressWidget;

  bool get eligible;

  bool get voteEnabled;

  bool get showCountDownWidget;
}
