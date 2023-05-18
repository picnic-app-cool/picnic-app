import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';

class GqlVoteCandidate {
  const GqlVoteCandidate({
    required this.user,
    required this.votesCount,
    required this.votesPercent,
    required this.position,
    required this.margin,
  });

  factory GqlVoteCandidate.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlVoteCandidate(
      user: GqlPublicProfile.fromJson(asT<Map<String, dynamic>>(json, 'user')),
      votesCount: asT<int>(json, 'votesCount'),
      votesPercent: asT<int>(json, 'votesPercent'),
      position: asT<int>(json, 'position'),
      margin: asT<double>(json, 'margin'),
    );
  }

  final GqlPublicProfile user;
  final int votesCount;
  final int votesPercent;
  final int position;
  final double margin;

  VoteCandidate toDomain(UserStore userStore) => VoteCandidate(
        publicProfile: user.toDomain(userStore),
        votesCount: votesCount,
        votesPercent: votesPercent.toDouble(),
        position: position,
        isDirector: position == 1,
        margin: margin,
      );
}
