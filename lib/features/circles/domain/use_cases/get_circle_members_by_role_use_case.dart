import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_by_role_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';

class GetCircleMembersByRoleUseCase {
  const GetCircleMembersByRoleUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetCircleMembersByRoleFailure, PaginatedList<CircleMember>>> execute({
    required Id circleId,
    required Cursor cursor,
    required List<CircleRole> roles,
    String searchQuery = '',
  }) async =>
      _circlesRepository
          .getCircleMembersByRole(
            circleId: circleId,
            cursor: cursor,
            roles: roles,
            searchQuery: searchQuery,
          )
          .mapSuccess(
            (electionCandidateList) =>
                electionCandidateList.mapItems((electionCandidate) => _getCircleMember(electionCandidate)),
          );

  CircleMember _getCircleMember(ElectionCandidate electionCandidate) {
    return CircleMember(
      user: electionCandidate.publicProfile,
      type: electionCandidate.role,
      mainRole: electionCandidate.mainRole,
    );
  }
}
