import 'package:picnic_app/core/data/graphql/model/gql_director_vote.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/governance.dart';

class GqlGovernance {
  const GqlGovernance({
    required this.circleId,
    required this.allVotesTotal,
    required this.myVotesTotal,
    required this.allVotes,
    required this.myVotes,
    required this.mySeedsCount,
  });

  factory GqlGovernance.fromJson(Map<String, dynamic>? json) {
    List<GqlDirectorVote>? allVotes;
    List<GqlDirectorVote>? myVotes;

    if (json != null && json['allVotes'] != null) {
      allVotes = (json['allVotes'] as List).map((e) => GqlDirectorVote.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (json != null && json['myVotes'] != null) {
      myVotes = (json['myVotes'] as List).map((e) => GqlDirectorVote.fromJson(e as Map<String, dynamic>)).toList();
    }

    return GqlGovernance(
      circleId: asT<String>(json, 'circleId'),
      allVotesTotal: asT<int>(json, 'allVotesTotal'),
      myVotesTotal: asT<int>(json, 'myVotesTotal'),
      mySeedsCount: asT<int>(json, 'mySeedsCount'),
      allVotes: allVotes,
      myVotes: myVotes,
    );
  }

  final String circleId;
  final int allVotesTotal;
  final int myVotesTotal;
  final List<GqlDirectorVote>? allVotes;
  final List<GqlDirectorVote>? myVotes;
  final int mySeedsCount;

  Governance toDomain(UserStore userStore) => Governance(
        circleId: Id(circleId),
        allVotesTotal: allVotesTotal,
        myVotesTotal: myVotesTotal,
        allVotes: allVotes?.map((e) => e.toDomain(userStore)).toList() ?? [],
        myVotes: myVotes?.map((e) => e.toDomain(userStore)).toList() ?? [],
        mySeedsCount: mySeedsCount,
      );
}
