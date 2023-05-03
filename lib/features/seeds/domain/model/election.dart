import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class Election extends Equatable {
  const Election({
    required this.id,
    required this.circleId,
    required this.dueTo,
    required this.membersVoted,
    required this.totalMembers,
    required this.seedsVoted,
    required this.iVoted,
    required this.maxSeedsVoted,
    required this.isSeedHolder,
    required this.votesPercent,
  });

  const Election.empty()
      : id = const Id.empty(),
        circleId = const Id.empty(),
        dueTo = '',
        membersVoted = 0,
        iVoted = false,
        isSeedHolder = false,
        totalMembers = 0,
        seedsVoted = 0,
        votesPercent = 0,
        maxSeedsVoted = 0;

  final Id id;
  final Id circleId;
  final String dueTo;
  final int membersVoted;
  final int totalMembers;
  final int seedsVoted;
  final int maxSeedsVoted;
  final bool iVoted;
  final bool isSeedHolder;
  final int votesPercent;

  DateTime? get dueToFormat => DateTime.tryParse(dueTo)?.toLocal();

  @override
  List<Object?> get props => [
        id,
        circleId,
        membersVoted,
        seedsVoted,
        totalMembers,
        maxSeedsVoted,
        iVoted,
        dueTo,
        isSeedHolder,
        votesPercent,
      ];

  Election copyWith({
    Id? id,
    Id? circleId,
    String? dueTo,
    int? membersVoted,
    int? seedsVoted,
    int? totalMembers,
    int? maxSeedsVoted,
    bool? iVoted,
    bool? isSeedHolder,
    int? votesPercent,
  }) {
    return Election(
      id: id ?? this.id,
      circleId: circleId ?? this.circleId,
      dueTo: dueTo ?? this.dueTo,
      membersVoted: membersVoted ?? this.membersVoted,
      totalMembers: totalMembers ?? this.totalMembers,
      seedsVoted: seedsVoted ?? this.seedsVoted,
      maxSeedsVoted: maxSeedsVoted ?? this.maxSeedsVoted,
      iVoted: iVoted ?? this.iVoted,
      isSeedHolder: isSeedHolder ?? this.isSeedHolder,
      votesPercent: votesPercent ?? this.votesPercent,
    );
  }
}
