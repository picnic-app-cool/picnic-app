import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/governance.dart';

class GetGovernanceUseCase {
  const GetGovernanceUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<GetElectionFailure, Governance>> execute({required Id circleId}) =>
      _seedsRepository.getGovernance(circleId: circleId);
}
