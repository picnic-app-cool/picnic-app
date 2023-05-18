import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/model/governance.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleGovernancePresentationModel implements CircleGovernanceViewModel {
  /// Creates the initial state
  CircleGovernancePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleGovernanceInitialParams initialParams,
  )   : governance = const Governance.empty(),
        circle = initialParams.circle,
        circleId = initialParams.circleId;

  /// Used for the copyWith method
  CircleGovernancePresentationModel._({
    required this.governance,
    required this.circle,
    required this.circleId,
  });

  static const int topCandidatesPodium = 3;

  @override
  final Governance governance;

  @override
  final Circle circle;

  @override
  final Id circleId;

  @override
  PaginatedList<VoteCandidate> get topCandidates {
    final topThreeCandidates = <VoteCandidate>[];
    final allCandidates = governance.allVotes.map((directorVote) => directorVote.candidate).toList();
    final electedDirector = allCandidates.firstWhereOrNull((candidate) => candidate.position == 1);
    final runnerUp = allCandidates.firstWhereOrNull((candidate) => candidate.position == 2);
    final thirdPosition = allCandidates.firstWhereOrNull((candidate) => candidate.position == 3);

    if (electedDirector != null) {
      topThreeCandidates.add(electedDirector);
    }

    if (runnerUp != null) {
      topThreeCandidates.add(runnerUp);
    }

    if (thirdPosition != null) {
      topThreeCandidates.add(thirdPosition);
    }

    return PaginatedList(
      pageInfo: const PageInfo.singlePage(),
      items: topThreeCandidates,
    );
  }

  @override
  PaginatedList<VoteCandidate> get candidatesIVoted => PaginatedList(
        pageInfo: const PageInfo.singlePage(),
        items: governance.myVotes.map((votedDirector) => votedDirector.candidate).toList(),
      );

  CircleGovernancePresentationModel copyWith({
    Governance? governance,
    Circle? circle,
    Id? circleId,
  }) {
    return CircleGovernancePresentationModel._(
      governance: governance ?? this.governance,
      circle: circle ?? this.circle,
      circleId: circleId ?? this.circleId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleGovernanceViewModel {
  Governance get governance;

  Id get circleId;

  Circle get circle;

  PaginatedList<VoteCandidate> get topCandidates;

  PaginatedList<VoteCandidate> get candidatesIVoted;
}
