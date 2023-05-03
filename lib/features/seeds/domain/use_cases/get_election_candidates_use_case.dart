import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart';

class GetElectionCandidatesUseCase {
  const GetElectionCandidatesUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<GetElectionCandidatesFailure, PaginatedList<ElectionCandidate>>> execute({
    required Id circleId,
    required Cursor nextPageCursor,
  }) async {
    return _seedsRepository.getElectionCandidates(circleId: circleId, nextPageCursor: nextPageCursor);
  }
}
