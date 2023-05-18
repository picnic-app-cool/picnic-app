import 'package:equatable/equatable.dart';

import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/director_vote.dart';

class Governance extends Equatable {
  const Governance({
    required this.circleId,
    required this.allVotesTotal,
    required this.myVotesTotal,
    required this.allVotes,
    required this.myVotes,
    required this.mySeedsCount,
  });

  const Governance.empty()
      : circleId = const Id.empty(),
        allVotesTotal = 0,
        myVotesTotal = 0,
        allVotes = const [],
        myVotes = const [],
        mySeedsCount = 0;

  final Id circleId;
  final int allVotesTotal;
  final int myVotesTotal;
  final List<DirectorVote> allVotes;
  final List<DirectorVote> myVotes;
  final int mySeedsCount;

  bool get isSeedHolder => mySeedsCount > 0;

  @override
  List<Object?> get props => [
        circleId,
        allVotesTotal,
        myVotesTotal,
        allVotes,
        myVotes,
        mySeedsCount,
      ];

  Governance copyWith({
    Id? circleId,
    int? allVotesTotal,
    int? myVotesTotal,
    List<DirectorVote>? allVotes,
    List<DirectorVote>? myVotes,
    int? mySeedsCount,
  }) {
    return Governance(
      circleId: circleId ?? this.circleId,
      allVotesTotal: allVotesTotal ?? this.allVotesTotal,
      myVotesTotal: myVotesTotal ?? this.myVotesTotal,
      allVotes: allVotes ?? this.allVotes,
      myVotes: myVotes ?? this.myVotes,
      mySeedsCount: mySeedsCount ?? this.mySeedsCount,
    );
  }
}
