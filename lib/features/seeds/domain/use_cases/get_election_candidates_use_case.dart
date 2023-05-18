import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';

class GetElectionCandidatesUseCase {
  const GetElectionCandidatesUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<GetElectionCandidatesFailure, PaginatedList<VoteCandidate>>> execute({
    required Id circleId,
    required Cursor nextPageCursor,
    required String searchQuery,
  }) async {
    return _seedsRepository.getCandidatesThatCanBeVoted(
      circleId: circleId,
      nextPageCursor: nextPageCursor,
      searchQuery: searchQuery,
    );
  }
}
