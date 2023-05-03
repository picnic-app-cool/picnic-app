import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/election.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_failure.dart';

class GetElectionUseCase {
  const GetElectionUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<GetElectionFailure, Election>> execute({required Id circleId}) =>
      _seedsRepository.getElection(circleId: circleId);
}
