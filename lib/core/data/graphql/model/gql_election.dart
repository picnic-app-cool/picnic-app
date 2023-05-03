import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/election.dart';

class GqlElection {
  const GqlElection({
    required this.id,
    required this.circleId,
    required this.dueTo,
    required this.membersVoted,
    required this.seedsVoted,
    required this.maxSeedsVoted,
    required this.circleMembersCount,
    required this.iVoted,
    required this.isSeedHolder,
    required this.votesPercent,
  });

  factory GqlElection.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlElection(
      id: asT<String>(json, 'id'),
      circleId: asT<String>(json, 'circleId'),
      dueTo: asT<String>(json, 'dueTo'),
      membersVoted: asT<int>(json, 'membersVoted'),
      seedsVoted: asT<int>(json, 'seedsVoted'),
      maxSeedsVoted: asT<int>(json, 'maxSeedsVoted'),
      circleMembersCount: asT<int>(json, 'circleMembersCount'),
      iVoted: asT<bool>(json, 'iVoted'),
      isSeedHolder: asT<bool>(json, 'isSeedHolder'),
      votesPercent: asT<int>(json, 'votesPercent'),
    );
  }

  final String id;
  final String circleId;
  final String dueTo;
  final int membersVoted;
  final int seedsVoted;
  final int maxSeedsVoted;
  final int circleMembersCount;
  final bool iVoted;
  final bool isSeedHolder;
  final int votesPercent;

  Election toDomain() => Election(
        id: Id(id),
        circleId: Id(circleId),
        dueTo: dueTo,
        membersVoted: membersVoted,
        seedsVoted: seedsVoted,
        maxSeedsVoted: maxSeedsVoted,
        totalMembers: circleMembersCount,
        iVoted: iVoted,
        isSeedHolder: isSeedHolder,
        votesPercent: votesPercent,
      );
}
