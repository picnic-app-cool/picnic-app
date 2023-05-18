import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';

class DirectorVote extends Equatable {
  const DirectorVote({
    required this.circleId,
    required this.candidate,
  });

  const DirectorVote.empty()
      : circleId = const Id.empty(),
        candidate = const VoteCandidate.empty();

  final Id circleId;
  final VoteCandidate candidate;

  @override
  List<Object?> get props => [
        circleId,
        candidate,
      ];

  DirectorVote copyWith({
    Id? circleId,
    VoteCandidate? candidate,
  }) {
    return DirectorVote(
      circleId: circleId ?? this.circleId,
      candidate: candidate ?? this.candidate,
    );
  }
}
