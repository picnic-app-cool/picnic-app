import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/un_vote_pod_failure.dart';

// ignore: unused_element
class UnVotePodUseCase {
  const UnVotePodUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<UnVotePodFailure, Unit>> execute({
    required Id podId,
  }) =>
      _circlesRepository.unVotePod(
        podId: podId,
      );
}
