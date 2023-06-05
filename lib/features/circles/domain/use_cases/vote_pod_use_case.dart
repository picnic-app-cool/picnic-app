import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/vote_pod_failure.dart';

// ignore: unused_element
class VotePodUseCase {
  const VotePodUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<VotePodFailure, Unit>> execute({
    required Id podId,
  }) =>
      _circlesRepository.votePod(
        podId: podId,
      );
}
