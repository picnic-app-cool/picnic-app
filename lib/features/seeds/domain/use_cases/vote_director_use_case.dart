import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_director_failure.dart';

class VoteDirectorUseCase {
  const VoteDirectorUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<VoteDirectorFailure, Id>> execute({required Id circleId, required Id userId}) async {
    return _seedsRepository.voteDirector(circleId: circleId, userId: userId);
  }
}
