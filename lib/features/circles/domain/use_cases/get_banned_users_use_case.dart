import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/get_banned_users_failure.dart';
import 'package:picnic_app/features/circles/domain/model/permanent_banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/temporary_banned_user.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';

class GetBannedUsersUseCase {
  const GetBannedUsersUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetBannedUsersFailure, PaginatedList<BannedUser>>> execute({
    required Id circleId,
    required Cursor cursor,
  }) async =>
      _circlesRepository.getBannedCircleMembers(circleId: circleId, cursor: cursor).mapSuccess(
            (electionCandidateList) =>
                electionCandidateList.mapItems((electionCandidate) => _getBannedUser(electionCandidate)),
          );

  BannedUser _getBannedUser(ElectionCandidate electionCandidate) {
    final user = electionCandidate.publicProfile;
    final bannedUser =
        electionCandidate.bannedTime == 0 ? _getPermanentBannedUser(user) : _getTemporaryBannedUser(electionCandidate);
    return bannedUser as BannedUser;
  }

  PermanentBannedUser _getPermanentBannedUser(PublicProfile user) {
    return PermanentBannedUser(
      userId: user.id,
      userName: user.username,
      userAvatar: user.profileImageUrl.url,
    );
  }

  TemporaryBannedUser _getTemporaryBannedUser(ElectionCandidate electionCandidate) {
    final user = electionCandidate.publicProfile;
    return TemporaryBannedUser(
      userId: user.id,
      userName: user.username,
      userAvatar: user.profileImageUrl.url,
      unbanTimeStamp: electionCandidate.bannedAt!.add(
        Duration(hours: electionCandidate.bannedTime),
      ),
    );
  }
}
