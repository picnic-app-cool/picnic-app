import 'package:picnic_app/core/data/graphql/model/gql_vote_candidate.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/director_vote.dart';

class GqlDirectorVote {
  const GqlDirectorVote({
    required this.circleId,
    required this.candidate,
  });

  factory GqlDirectorVote.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlDirectorVote(
      circleId: asT<String>(json, 'circleId'),
      candidate: GqlVoteCandidate.fromJson(asT<Map<String, dynamic>>(json, 'candidate')),
    );
  }

  final String circleId;
  final GqlVoteCandidate candidate;

  DirectorVote toDomain(UserStore userStore) => DirectorVote(
        circleId: Id(circleId),
        candidate: candidate.toDomain(userStore),
      );
}
